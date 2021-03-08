import 'package:flutter/foundation.dart';

import '../models/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> listTodos({@required String meId});
}
