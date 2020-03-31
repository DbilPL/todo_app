import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
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

              if (isUserRegistered) {
              } else
                BlocProvider.of<TodoBloc>(context)
                    .add(ReorderListLocal(state.list, oldIndex, newIndex));
            },
          );
        else if (state is LoadingTodoState) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
        } else
          return Center(
            child: Text(
              'No items!',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          );
      },
    );
  }
}
