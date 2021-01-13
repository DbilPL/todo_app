import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

class TodoModalBottomSheetTodo extends StatefulWidget {
  final String groupName;
  final int id;

  const TodoModalBottomSheetTodo(this.groupName, this.id);

  @override
  _TodoModalBottomSheetTodoState createState() =>
      _TodoModalBottomSheetTodoState();
}

class _TodoModalBottomSheetTodoState extends State<TodoModalBottomSheetTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xfff8f8f8),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Text(
                  'Enter todo title',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  controller: _titleController,
                ),
                Text(
                  'Enter todo body',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Body',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  controller: _bodyController,
                  keyboardType: TextInputType.multiline,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'Enter todo date',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        DatePicker.showDateTimePicker(
                          context,
                          minTime: DateTime.now(),
                          currentTime: DateTime.now(),
                          theme: DatePickerTheme(
                            backgroundColor: Theme.of(context).backgroundColor,
                            doneStyle: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                            cancelStyle: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                            itemStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            headerColor: Theme.of(context).primaryColor,
                          ),
                          onConfirm: (date) {
                            _dateController.value = TextEditingValue(
                              text: date != null
                                  ? '${date.year}/${date.month}/${date.day}/${date.hour}/${date.minute}'
                                  : '',
                            );
                          },
                        );
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Pick date',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        final todoState =
                            BlocProvider.of<TodoBloc>(context).state;

                        final authState =
                            BlocProvider.of<AuthBloc>(context).state;

                        if (authState is Entered) {
                          final isUserRegistered = isRegistered(context);
                          if (_titleController.text != '' &&
                              _bodyController.text != '') {
                            if (isUserRegistered) {
                              final user = authState.user as UsualUserModel;

                              BlocProvider.of<TodoBloc>(context).add(
                                AddTodoToGroupRemote(
                                  widget.groupName,
                                  _titleController.text,
                                  _bodyController.text,
                                  _dateController.text,
                                  todoState.list,
                                  widget.id,
                                  user.uid,
                                ),
                              );
                            } else {
                              BlocProvider.of<TodoBloc>(context).add(
                                AddTodoToGroupLocal(
                                  widget.groupName,
                                  _titleController.text,
                                  _bodyController.text,
                                  _dateController.text,
                                  todoState.list,
                                  widget.id,
                                ),
                              );
                            }
                          } else {
                            BlocProvider.of<TodoBloc>(context).add(TodoFailure(
                                'Not valid texts.', todoState.list));
                          }
                        } else {
                          BlocProvider.of<TodoBloc>(context).add(TodoFailure(
                              'How did you get there?!.', todoState.list));
                        }
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
