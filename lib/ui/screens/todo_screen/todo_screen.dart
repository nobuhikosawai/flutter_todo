import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_example/ui/screens/todo_screen/todo_item.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controllers/me_controller.dart';
import '../../controllers/todo_controller.dart';
import 'completed_todo_item.dart';
import 'todo_input_form.dart';

class TodoScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final me = useProvider(meProvider);
    final meId = me.data?.value?.id;

    if (meId == null) {
      return Container();
    }

    final todos = useProvider(todoProvider(meId));
    final todoController = useProvider(todoProvider(meId).notifier);

    final displayCompleted = useState<bool>(false);

    return todos.when(
        data: (todos) {
          final uncompletedTodos = todos.uncompletedItems;
          final completedTodos = todos.completedItems;

          return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: SafeArea(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate([
                                Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text('My Todos',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2)),
                              ]),
                            ),
                            SliverReorderableList(
                              onReorder: (oldIndex, newIndex) {
                                final targetTodo = uncompletedTodos[oldIndex];
                                todoController.updateOrder(
                                    targetTodo.id, newIndex);
                              },
                              itemBuilder: (context, index) {
                                final todo = uncompletedTodos[index];
                                return Container(
                                    key: Key(todo.id),
                                    child: ReorderableDragStartListener(
                                      index: index,
                                      child: Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          child: TodoItem(
                                            todo: todo,
                                            onFocusChange:
                                                todoController.update,
                                            onChange: (_) => todoController
                                                .completeTodo(todo.id),
                                            // TODO: show snackBar and enable undo
                                            onDismissed: () =>
                                                todoController.delete(todo.id),
                                          )),
                                    ));
                              },
                              itemCount: todos.uncompletedItems.length,
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate([
                                completedTodos.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(children: [
                                          TextButton(
                                              onPressed: () {
                                                displayCompleted.value =
                                                    !displayCompleted.value;
                                              },
                                              style: TextButton.styleFrom(
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  primary: Colors.black54,
                                                  backgroundColor:
                                                      Colors.black12),
                                              child: Row(children: [
                                                Text(
                                                  'Completed',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                displayCompleted.value
                                                    ? Icon(Icons.arrow_drop_up)
                                                    : Icon(
                                                        Icons.arrow_drop_down)
                                              ])),
                                        ]))
                                    : Container(),
                              ]),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final todo = completedTodos[index];

                                  if (!displayCompleted.value) {
                                    return Container();
                                  }

                                  return Container(
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      child: CompletedTodoItem(
                                        key: Key(todo.id),
                                        todo: todo,
                                        onChange: (_) => todoController
                                            .uncompleteTodo(todo.id),
                                        // TODO: show snackBar and enable undo
                                        onDismissed: () =>
                                            todoController.delete(todo.id),
                                      ));
                                },
                                childCount: completedTodos.length,
                              ),
                            )
                          ],
                        ))),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
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
                                  onSaved: (str) =>
                                      todoController.createTodo(str)),
                            ],
                          )));
                        });
                  },
                  child: Icon(Icons.add),
                ),
              ));
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Container();
        });
  }
}
