import 'package:flutter/material.dart';
import 'package:flutter_example/ui/common/custom_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'todo_input_field.dart';

class TodoScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final todos = useState([
      {'key': '1', 'title': 'TODO1', 'completed': false},
      {'key': '2', 'title': 'TODO2', 'completed': true},
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Awesome Todos!'),
        backgroundColor: CustomColor.primary,
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final todosDup = [...todos.value];
          final item = todosDup.removeAt(oldIndex);
          todosDup.insert(newIndex, item);
          todos.value = todosDup;
        },
        children: [
          for (final todo in todos.value)
            CheckboxListTile(
                key: Key(todo['key'] as String),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: CustomColor.primary,
                title: Text(todo['title'] as String),
                value: todo['completed'] as bool,
                onChanged: (value) {})
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.primary,
        onPressed: () {
          showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0)),
              ),
              context: context,
              builder: (buildContext) {
                return TodoInputField();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
