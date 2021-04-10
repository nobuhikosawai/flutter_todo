import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../data/entities/todos.dart';
import '../../data/providers/todo_repository_provider.dart';
import '../../data/repositories/todo_repository.dart';

final todoProvider = StateNotifierProvider.family<TodoController, AsyncValue<Todos>, String>(
    (ref, meId) => TodoController(ref, meId: meId));

class TodoController extends StateNotifier<AsyncValue<Todos>> {
  TodoController(this._reference, {required this.meId})
      : super(AsyncValue.loading()) {
    _listTodos();
  }

  late TodoRepository _repository;

  final String meId;

  final ProviderReference _reference;

  void _listTodos() {
    _repository = _reference.read(todoRepositoryProvider);
    _repository.listTodos(meId: meId).listen((todos) {
      state = AsyncValue.data(todos);
    });
  }

  Future<void> createTodo(String title) async {
    _repository = _reference.read(todoRepositoryProvider);
    final position = state.data!.value.newPosition();
    await _repository.createTodo(meId: meId, title: title, position: position);
  }

  Future<void> updateOrder(String id, int newIndex) async {
    _repository = _reference.read(todoRepositoryProvider);
    final newState = state.data!.value.reorder(id, newIndex);
    state = AsyncValue.data(newState);
    final position =
        newState.uncompletedItems.firstWhere((item) => item.id == id).position;
    await _repository.updateTodo(id: id, position: position);
  }

  Future<void> completeTodo(String id) async {
    _repository = _reference.read(todoRepositoryProvider);
    final newState = state.data!.value.complete(id);
    state = AsyncValue.data(newState);
    final completedTodo =
        newState.completedItems.firstWhere((item) => item.id == id);
    await _repository.updateTodo(
        id: id,
        completed: completedTodo.completed,
        position: completedTodo.position);
  }

  Future<void> uncompleteTodo(String id) async {
    _repository = _reference.read(todoRepositoryProvider);
    final newState = state.data!.value.uncomplete(id);
    state = AsyncValue.data(newState);
    final uncompletedTodo =
        newState.uncompletedItems.firstWhere((item) => item.id == id);
    await _repository.updateTodo(
        id: id,
        completed: uncompletedTodo.completed,
        position: uncompletedTodo.position);
  }

  Future<void> update({required String id, required String title}) async {
    _repository = _reference.read(todoRepositoryProvider);
    final newState = state.data!.value.update(id: id, title: title);
    state = AsyncValue.data(newState);
    final newTitle =
        newState.uncompletedItems.firstWhere((item) => item.id == id).title;
    await _repository.updateTodo(id: id, title: newTitle);
  }

  Future<void> delete(String id) async {
    _repository = _reference.read(todoRepositoryProvider);
    final newState = state.data!.value.delete(id);
    state = AsyncValue.data(newState);
    await _repository.deleteTodo(id: id);
  }
}
