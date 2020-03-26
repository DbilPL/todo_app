import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

class TodoModalBottomSheetAnonym extends StatefulWidget {
  @override
  _TodoModalBottomSheetAnonymState createState() =>
      _TodoModalBottomSheetAnonymState();
}

class _TodoModalBottomSheetAnonymState
    extends State<TodoModalBottomSheetAnonym> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 820,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Enter group name',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ),
                TextFormField(
                  maxLength: 15,
                  autofocus: true,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(),
                  ),
                  controller: _controller,
                ),
                RaisedButton(
                  onPressed: () {
                    final todoState = BlocProvider.of<TodoBloc>(context).state;

                    if (_controller.text != '')
                      BlocProvider.of<TodoBloc>(context).add(
                          AddTodoGroupLocal(_controller.text, todoState.list));
                    else
                      BlocProvider.of<TodoBloc>(context).add(
                          TodoFailure('Not valid group name.', todoState.list));

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
