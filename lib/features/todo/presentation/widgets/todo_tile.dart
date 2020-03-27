import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
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
    final isUserRegistered = isRegistered(context);

    return Dismissible(
      onDismissed: (dismiss) {
        if (dismiss == DismissDirection.startToEnd) {
          if (isUserRegistered) {
          } else
            BlocProvider.of<TodoBloc>(context).add(
              TodoChangeStatusLocal(
                BlocProvider.of<TodoBloc>(context).state.list,
                widget.title,
                todo,
              ),
            );
        }
        if (dismiss == DismissDirection.endToStart) {
          if (isUserRegistered) {
          } else
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
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  todo.isComplete
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24,
                        )
                      : Text(''),
                ],
              ),
              Text(
                todo.body,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
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
