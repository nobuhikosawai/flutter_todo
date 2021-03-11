import 'package:flutter/material.dart';
import 'package:flutter_example/ui/common/custom_color.dart';

class TodoInputField extends StatefulWidget {
  TodoInputField({@required this.onSaved});

  final Future<void> Function(String) onSaved;

  @override
  State<StatefulWidget> createState() {
    return TodoInputFieldState(onSaved);
  }
}

class TodoInputFieldState extends State<TodoInputField> {
  TodoInputFieldState(this._onSaved);

  final _todoTitleController = TextEditingController();
  String _todoTitleErrorText;
  final _formKey = GlobalKey<FormState>();
  final Function _onSaved;

  Future<void> _onSavedWithClear(String title) async {
    await _onSaved(title);
    _todoTitleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Todo',
                  errorText: _todoTitleErrorText,
                  border: InputBorder.none,
                ),
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                controller: _todoTitleController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input your todoTitle.';
                  }
                  return null;
                },
                onFieldSubmitted: (title) async {
                  await _onSavedWithClear(title);
                  Navigator.pop(context);
                },
                onSaved: (title) async {
                  await _onSavedWithClear(title);
                  Navigator.pop(context);
                },
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          _formKey.currentState.save();
                        } catch (error) {
                          await showDialog<void>(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: <Widget>[
                                  SimpleDialogOption(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('${error.toString()}'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Text('Save',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.primary)),
                  ))
            ],
          ),
        ));
  }
}
