import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_group_view.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.list.length != 0)
          return ReorderableListView(
            children: state.list
                .map((val) => TodoGroupView(
                      todos: val,
                      key: Key(val.groupName),
                    ))
                .toList(),
            onReorder: (int oldIndex, int newIndex) {
              final isUserRegistered = isRegistered(context);

              final authState = BlocProvider.of<AuthBloc>(context).state;

              if (authState is Entered) if (isUserRegistered) {
                final user = authState.user as UsualUserModel;

                BlocProvider.of<TodoBloc>(context).add(ReorderListRemote(
                    state.list, oldIndex, newIndex, user.uid));
              } else {
                BlocProvider.of<TodoBloc>(context)
                    .add(ReorderListLocal(state.list, oldIndex, newIndex));
              }
            },
          );
        else if (state is FailureTodoStateInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    final authState = BlocProvider.of<AuthBloc>(context).state;

                    if (authState is Entered) {
                      if (isRegistered(context)) {
                        final user = authState.user as UsualUserModel;

                        BlocProvider.of<TodoBloc>(context).add(
                          LoadRemoteTodoInitial(
                            [],
                            user.uid,
                          ),
                        );
                      } else {
                        BlocProvider.of<TodoBloc>(context).add(
                          const LoadLocalTodoInitial(
                            [],
                          ),
                        );
                      }
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Reload',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is LoadingTodoState) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'No items!',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          );
        }
      },
    );
  }
}
