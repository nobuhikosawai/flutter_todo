import 'package:flutter/foundation.dart';
import 'package:flutter_example/data/providers/todo_repository_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../data/models/todo.dart';
import '../../data/repositories/todo_repository.dart';

final todoProvider = StateNotifierProvider.family<TodoController, String>(
    (ref, meId) => TodoController(ref, meId: meId));

class TodoController extends StateNotifier<AsyncValue<List<Todo>>> {
  TodoController(this._reference, {@required this.meId})
      : super(AsyncValue.loading()) {
    _listTodos(meId);
  }

  TodoRepository _repository;

  final String meId;

  final ProviderReference _reference;

  void _listTodos(String meId) {
    _repository ??= _reference.read(todoRepositoryProvider);
    _repository.listTodos(meId: meId).listen((todos) {
      state = AsyncValue.data(todos);
    });
  }
}
