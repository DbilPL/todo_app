import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

class TodoModalBottomSheet extends StatefulWidget {
  final int uniqueID;

  const TodoModalBottomSheet({Key key, this.uniqueID}) : super(key: key);

  @override
  _TodoModalBottomSheetState createState() => _TodoModalBottomSheetState();
}

class _TodoModalBottomSheetState extends State<TodoModalBottomSheet> {
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
                Text(
                  'Enter group name',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
                TextFormField(
                  autofocus: true,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  controller: _controller,
                ),
                RaisedButton(
                  onPressed: () {
                    final todoState = BlocProvider.of<TodoBloc>(context).state;

                    if (_controller.text != '') {
                      final isUserRegistered = isRegistered(context);

                      if (isUserRegistered) {
                        final authState =
                            BlocProvider.of<AuthBloc>(context).state;

                        if (authState is Entered)
                          BlocProvider.of<TodoBloc>(context).add(
                            AddTodoGroupRemote(
                              _controller.text,
                              todoState.list,
                              authState.user.props[0],
                              widget.uniqueID,
                            ),
                          );
                      } else
                        BlocProvider.of<TodoBloc>(context).add(
                          AddTodoGroupLocal(
                            _controller.text,
                            todoState.list,
                            widget.uniqueID,
                          ),
                        );
                    } else
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
