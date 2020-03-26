import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

class TodoModalBottomSheetAnonymTodo extends StatefulWidget {
  final String groupName;

  TodoModalBottomSheetAnonymTodo(this.groupName);

  @override
  _TodoModalBottomSheetAnonymTodoState createState() =>
      _TodoModalBottomSheetAnonymTodoState();
}

class _TodoModalBottomSheetAnonymTodoState
    extends State<TodoModalBottomSheetAnonymTodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _dateController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
                  maxLength: 15,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  decoration: InputDecoration(hintText: 'Title'),
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
                  maxLength: null,
                  decoration: InputDecoration(hintText: 'Body'),
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        DatePicker.showDateTimePicker(context,
                            minTime: DateTime.now(),
                            currentTime: DateTime.now(),
                            theme: DatePickerTheme(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              doneStyle: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                              cancelStyle: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                              itemStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              headerColor: Theme.of(context).primaryColor,
                            ), onConfirm: (date) {
                          _dateController.value = TextEditingValue(
                              text: date != null
                                  ? '${date.year}/${date.month}/${date.day}/${date.hour}/${date.minute}'
                                  : '');
                        });
                      },
                      child: Text(
                        'Pick date',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    RaisedButton(
                      onPressed: () {
                        final todoState =
                            BlocProvider.of<TodoBloc>(context).state;

                        if (_titleController.text != '' &&
                            _bodyController.text != '')
                          BlocProvider.of<TodoBloc>(context).add(
                            AddTodoToGroupLocal(
                                widget.groupName,
                                _titleController.text,
                                _bodyController.text,
                                _dateController.text,
                                todoState.list),
                          );
                        else
                          BlocProvider.of<TodoBloc>(context).add(
                              TodoFailure('Not valid texts.', todoState.list));

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xfff8f8f8),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
