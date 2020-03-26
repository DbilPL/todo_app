import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

class TodoTile extends StatefulWidget {
  final TODO todo;
  final String title;

  const TodoTile({Key key, this.todo, this.title}) : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState(this.todo);
}

class _TodoTileState extends State<TodoTile> {
  final TODO todo;

  _TodoTileState(this.todo);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (dismiss) {
        if (dismiss == DismissDirection.startToEnd) {
          BlocProvider.of<TodoBloc>(context).add(
            TodoChangeStatusLocal(
              BlocProvider.of<TodoBloc>(context).state.list,
              widget.title,
              todo,
            ),
          );
        }
        if (dismiss == DismissDirection.endToStart) {
          BlocProvider.of<TodoBloc>(context).add(
            DeleteTodoLocal(
              todo.title,
              widget.title,
              BlocProvider.of<TodoBloc>(context).state.list,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: todo.isComplete
              ? Colors.green
              : Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontSize: 20,
                      color: todo.isComplete
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    todo.date != null
                        ? '${todo.date.year}/${todo.date.month}/${todo.date.day} ${todo.date.hour}:${todo.date.minute}'
                        : 'No date',
                    style: TextStyle(
                      fontSize: 12,
                      color: todo.isComplete
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                todo.body,
                style: TextStyle(
                  color: todo.isComplete
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      key: Key(todo.title),
    );
  }
}
