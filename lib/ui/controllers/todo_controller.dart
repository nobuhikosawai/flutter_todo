import 'package:flutter/foundation.dart';
import 'package:flutter_example/data/providers/todo_repository_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../data/models/todos.dart';
import '../../data/repositories/todo_repository.dart';

final todoProvider = StateNotifierProvider.family<TodoController, String>(
    (ref, meId) => TodoController(ref, meId: meId));

class TodoController extends StateNotifier<AsyncValue<Todos>> {
  TodoController(this._reference, {@required this.meId})
      : super(AsyncValue.loading()) {
    _listTodos();
  }

  TodoRepository _repository;

  final String meId;

  final ProviderReference _reference;

  void _listTodos() {
    _repository ??= _reference.read(todoRepositoryProvider);
    _repository.listTodos(meId: meId).listen((todos) {
      state = AsyncValue.data(todos);
    });
  }

  Future<void> createTodo(String title) async {
    _repository ??= _reference.read(todoRepositoryProvider);
    final position = state.data.value.newPosition();
    await _repository.createTodo(meId: meId, title: title, position: position);
  }

  Future<void> updateOrder(String id, int newIndex) async {
    _repository ??= _reference.read(todoRepositoryProvider);
    final newState = state.data.value.reorder(id, newIndex);
    state = AsyncValue.data(newState);
    final position =
        newState.items.firstWhere((item) => item.id == id).position;
    await _repository.updateTodo(id: id, position: position);
  }
}
