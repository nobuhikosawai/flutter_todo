import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/todo.dart';
import '../../common/custom_color.dart';

class TodoItem extends HookWidget {
  TodoItem(
      {@required this.todo,
      @required this.onChange,
      @required this.onFocusChange,
      @required this.onDismissed,
      Key key})
      : super(key: key);

  final Todo todo;
  final ValueChanged<bool> onChange;
  final Function onFocusChange;
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
    final titleEditController = useTextEditingController();
    final itemFocusNode = useFocusNode();

    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textFieldFocusNode = useFocusNode();

    return Dismissible(
        key: Key(todo.id),
        direction: DismissDirection.endToStart,
        background: _slideLeftBackground(),
        onDismissed: (_direction) {
          onDismissed();
        },
        child: Material(
            child: Focus(
                focusNode: itemFocusNode,
                onFocusChange: (focused) {
                  if (focused) {
                    titleEditController.text = todo.title;
                  } else {
                    onFocusChange(id: todo.id, title: titleEditController.text);
                  }
                },
                child: InkWell(
                  onTap: () {
                    itemFocusNode.requestFocus();
                    textFieldFocusNode.requestFocus();
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
                        isFocused
                            ? Expanded(
                                child: TextField(
                                autofocus: true,
                                focusNode: textFieldFocusNode,
                                controller: titleEditController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ))
                            : Expanded(child: Text(todo.title))
                      ],
                    ),
                  ),
                ))));
  }
}
