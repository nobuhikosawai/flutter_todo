import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_example/ui/screens/todo_screen/todo_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/custom_color.dart';
import '../../controllers/me_controller.dart';
import '../../controllers/todo_controller.dart';
import 'todo_input_form.dart';

class TodoScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final me = useProvider(meProvider.state);
    final meId = me.data?.value?.id;

    if (meId == null) Container();

    final todos = useProvider(todoProvider(meId).state);
    final todoController = useProvider(todoProvider(meId));

    return todos.when(
        data: (todos) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Your Awesome Todos!'),
                backgroundColor: CustomColor.primary,
              ),
              body: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final targetTodo = todos.items[oldIndex];
                  todoController.updateOrder(targetTodo.id, newIndex);
                },
                children: [
                  for (final todo in todos.items)
                    TodoItem(
                        key: Key(todo.id),
                        todo: todo,
                        onFocusChange: (_) => print('focus changed'),
                        onChange: (_) => todoController.toggleTodo(todo.id))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: CustomColor.primary,
                onPressed: () {
                  // ref: https://github.com/flutter/flutter/issues/18564#issuecomment-519429440
                  showModalBottomSheet<void>(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0)),
                      ),
                      context: context,
                      builder: (buildContext) {
                        return SingleChildScrollView(
                            child: Container(
                                child: Wrap(
                                  children: [
                                    TodoInputForm(
                                        onSaved: (str) => todoController.createTodo(str)),
                                  ],
                                )));
                      });
                },
                child: Icon(Icons.add),
              ),
            )
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Container();
        });
  }
}
