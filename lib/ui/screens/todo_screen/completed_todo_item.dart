import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/todo.dart';
import '../../common/custom_color.dart';

class CompletedTodoItem extends HookWidget {
  CompletedTodoItem(
      {@required this.todo,
      @required this.onChange,
      @required this.onDismissed,
      Key key})
      : super(key: key);

  final Todo todo;
  final ValueChanged<bool> onChange;
  final Function onDismissed;

  Widget _slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              ' Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(todo.id),
        direction: DismissDirection.endToStart,
        background: _slideLeftBackground(),
        onDismissed: (_direction) {
          onDismissed();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: todo.completed,
                onChanged: onChange,
                activeColor: CustomColor.primary,
              ),
              Expanded(
                  child: Text(
                todo.title,
                style: TextStyle(
                    decoration: TextDecoration.lineThrough, color: Colors.grey),
              ))
            ],
          ),
        ));
  }
}
