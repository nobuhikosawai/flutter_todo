import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo.freezed.dart';

@freezed
abstract class Todo with _$Todo {
  factory Todo({
    @required String id,
    @required String title,
    @required bool completed,
    @required double position,
  }) = _Todo;
}
