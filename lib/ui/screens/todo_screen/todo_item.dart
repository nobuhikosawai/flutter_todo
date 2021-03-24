import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/todo.dart';
import '../../common/custom_color.dart';

class TodoItem extends HookWidget {
  TodoItem(
      {@required this.todo,
      @required this.onChange,
      @required this.onFocusChange,
      Key key})
      : super(key: key);

  final Todo todo;
  final ValueChanged<bool> onChange;
  final ValueChanged<bool> onFocusChange;

  @override
  Widget build(BuildContext context) {
    final titleEditController = useTextEditingController();
    final itemFocusNode = useFocusNode();

    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textFieldFocusNode = useFocusNode();

    return Focus(
        key: Key(todo.id),
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            titleEditController.text = todo.title;
          } else {
            onFocusChange(focused);
          }
        },
        child: InkWell(
          key: Key(todo.id),
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
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ))
                    : Expanded(child: Text(todo.title))
              ],
            ),
          ),
        ));
  }
}
