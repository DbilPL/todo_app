import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/pages/todo_tile_view_page.dart';

class TodoTile extends StatefulWidget {
  final TODO todo;
  final String title;
  final int id;

  const TodoTile({Key key, this.todo, this.title, this.id}) : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState(this.todo);
}

class _TodoTileState extends State<TodoTile> {
  final TODO todo;

  _TodoTileState(this.todo);

  @override
  Widget build(BuildContext context) {
    final isUserRegistered = isRegistered(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => TodoTileViewPage(
              todo: todo,
            ),
          ),
        );
      },
      child: Dismissible(
        onDismissed: (dismiss) {
          if (dismiss == DismissDirection.startToEnd) {
            final authState = BlocProvider.of<AuthBloc>(context).state;
            if (authState is Entered) {
              if (isUserRegistered) {
                BlocProvider.of<TodoBloc>(context).add(
                  TodoChangeStatusRemote(
                    BlocProvider.of<TodoBloc>(context).state.list,
                    widget.title,
                    todo,
                    widget.id,
                    authState.user.props[0],
                  ),
                );
              } else
                BlocProvider.of<TodoBloc>(context).add(
                  TodoChangeStatusLocal(
                    BlocProvider.of<TodoBloc>(context).state.list,
                    widget.title,
                    todo,
                    widget.id,
                  ),
                );
            }
          }
          if (dismiss == DismissDirection.endToStart) {
            final authState = BlocProvider.of<AuthBloc>(context).state;
            if (authState is Entered) {
              if (isUserRegistered) {
                BlocProvider.of<TodoBloc>(context).add(
                  DeleteTodoRemote(
                    todo.title,
                    widget.title,
                    BlocProvider.of<TodoBloc>(context).state.list,
                    widget.id,
                    authState.user.props[0],
                  ),
                );
              } else
                BlocProvider.of<TodoBloc>(context).add(
                  DeleteTodoLocal(
                    todo.title,
                    widget.title,
                    BlocProvider.of<TodoBloc>(context).state.list,
                    widget.id,
                  ),
                );
            }
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
                        Hero(
                          tag: todo.title,
                          flightShuttleBuilder: (
                            BuildContext flightContext,
                            Animation<double> animation,
                            HeroFlightDirection flightDirection,
                            BuildContext fromHeroContext,
                            BuildContext toHeroContext,
                          ) {
                            return DefaultTextStyle(
                              style: DefaultTextStyle.of(toHeroContext).style,
                              child: toHeroContext.widget,
                            );
                          },
                          child: Text(
                            todo.title.length > 15
                                ? todo.title.substring(0, 13) + '...'
                                : todo.title,
                            style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          todo.date != null
                              ? '${todo.date.year}/${todo.date.month}/${todo.date.day} ${todo.date.hour}:${todo.date.minute < 10 ? '0' + todo.date.minute.toString() : todo.date.minute}'
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
                Hero(
                  tag: todo.body,
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    return DefaultTextStyle(
                      style: DefaultTextStyle.of(toHeroContext).style,
                      child: toHeroContext.widget,
                    );
                  },
                  child: Text(
                    todo.body,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
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
      ),
    );
  }
}
