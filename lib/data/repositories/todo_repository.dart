import 'package:flutter/foundation.dart';

import '../models/todos.dart';

abstract class TodoRepository {
  Stream<Todos> listTodos({@required String meId});

  Future<void> createTodo(
      {@required String meId,
      @required String title,
      @required double position});

  Future<void> updateTodo(
      {@required String id, String title, bool completed, double position});

  Future<void> deleteTodo({@required String id});
}
