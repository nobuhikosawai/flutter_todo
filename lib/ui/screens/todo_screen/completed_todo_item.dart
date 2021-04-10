import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/entities/todo.dart';

class CompletedTodoItem extends HookWidget {
  CompletedTodoItem(
      {required this.todo,
      required this.onChange,
      required this.onDismissed,
      Key? key})
      : super(key: key);

  final Todo todo;
  final ValueChanged<bool?> onChange;
  final Function onDismissed;

  Widget _slideLeftBackground(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              ' Delete',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
        background: _slideLeftBackground(context),
        onDismissed: (_direction) {
          onDismissed();
        },
        child: Material(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: todo.completed,
                    onChanged: onChange,
                    activeColor: Theme.of(context).accentColor,
                  ),
                  Expanded(
                      child: Text(
                    todo.title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ))
                ],
              ),
            )));
  }
}
