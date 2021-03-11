import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/custom_color.dart';
import '../../controllers/me_controller.dart';
import '../../controllers/todo_controller.dart';
import 'todo_input_field.dart';

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
          return Scaffold(
            appBar: AppBar(
              title: Text('Your Awesome Todos!'),
              backgroundColor: CustomColor.primary,
            ),
            body: ReorderableListView(
              onReorder: (oldIndex, newIndex) {
                // FIXME
                // if (oldIndex < newIndex) {
                //   newIndex -= 1;
                // }
                // final todosDup = [...todos.data.value];
                // final item = todosDup.removeAt(oldIndex);
                // todosDup.insert(newIndex, item);
                // todos.data.value = todosDup;
              },
              children: [
                for (final todo in todos)
                  CheckboxListTile(
                      key: Key(todo.id),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: CustomColor.primary,
                      title: Text(todo.title),
                      value: todo.completed,
                      onChanged: (value) {})
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
                          TodoInputField(
                              onSaved: (str) => todoController.createTodo(str)),
                        ],
                      )));
                    });
              },
              child: Icon(Icons.add),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Container();
        });
  }
}
