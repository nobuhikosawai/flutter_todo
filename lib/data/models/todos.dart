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
    // https://qiita.com/gypsy/items/7bd2a4aeb1b419ce8914#%E4%BD%8D%E7%BD%AE%E3%82%92%E6%B5%AE%E5%8B%95%E5%B0%8F%E6%95%B0%E7%82%B9%E3%81%A7%E8%A1%A8%E7%8F%BE%E3%81%97%E3%81%9F%E5%A0%B4%E5%90%88%E3%81%AE%E4%B8%A6%E3%81%B3%E6%9B%BF%E3%81%88%E5%87%A6%E7%90%86
    return items.isNotEmpty ? items[0].position + 65535.0 : 65535.0;
  }

  Todos reorder(String id, int newIndex) {
    final newPosition = _reorderedPositionAtNewIndex(newIndex);
    final newItems = items.map((item) {
      if (item.id == id) {
        return item.copyWith(position: newPosition);
      } else {
        return item;
      }
    }).toList();
    newItems.sort((a, b) => b.position.compareTo(a.position));

    return copyWith(items: newItems);
  }

  double _reorderedPositionAtNewIndex(int newIndex) {
    if (items.isEmpty) {
      throw StateError('Empty items');
    }

    double newPosition;
    if (newIndex == 0) {
      // list is descending order.
      newPosition = items[0].position + 65535.0;
    } else if (newIndex == items.length - 1) {
      newPosition = items[items.length - 1].position * 0.5;
    } else {
      final prevTodo = items[newIndex - 1];
      final nextTodo = items[newIndex + 1];
      newPosition = (prevTodo.position + nextTodo.position) * 0.5;
    }
    return newPosition;
  }
}
