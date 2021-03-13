import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'todo.dart';

part 'todos.freezed.dart';

@freezed
abstract class Todos implements _$Todos {
  const Todos._();

  const factory Todos({
    @required List<Todo> items,
  }) = _Todos;

  double newPosition() {
    // list is descending order.
    return items.isNotEmpty ? items[0].position * 2 : 1024;
  }
}
