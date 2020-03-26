import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_group_view.dart';

class AnonymousTodoList extends StatefulWidget {
  @override
  _AnonymousTodoListState createState() => _AnonymousTodoListState();
}

class _AnonymousTodoListState extends State<AnonymousTodoList> {
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
              BlocProvider.of<TodoBloc>(context)
                  .add(ReorderListLocal(state.list, oldIndex, newIndex));
            },
          );
        else
          return Center(
            child: Text(
              'No items!',
              style: TextStyle(
                color: Theme.of(context).textTheme.caption.color,
                fontSize: 25,
              ),
            ),
          );
      },
    );
  }
}
