import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_modal_bottom_sheet_todo.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_tile.dart';

class TodoGroupView extends StatefulWidget {
  final TODOGroupModel todos;

  TodoGroupView({Key key, this.todos}) : super(key: key);

  @override
  _TodoGroupViewState createState() => _TodoGroupViewState();
}

class _TodoGroupViewState extends State<TodoGroupView> {
  List<int> ids;

  @override
  void initState() {
    ids = List(widget.todos.todoList.length);

    for (int i = 0; i < widget.todos.todoList.length; i++) {
      ids[i] = widget.todos.uniqueID + i;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).backgroundColor,
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  widget.todos.groupName.length > 15
                      ? widget.todos.groupName.substring(0, 13) + '...'
                      : widget.todos.groupName,
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        final isUserRegistered = isRegistered(context);

                        if (isUserRegistered) {
                        } else
                          BlocProvider.of<TodoBloc>(context).add(
                            DeleteTodoGroupLocal(
                              widget.todos.groupName,
                              BlocProvider.of<TodoBloc>(context).state.list,
                              ids,
                            ),
                          );
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Theme.of(context).backgroundColor,
                        size: 19,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return TodoModalBottomSheetTodo(
                              widget.todos.groupName,
                              widget.todos.todoList.length +
                                  widget.todos.uniqueID,
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.border_color,
                        color: Theme.of(context).backgroundColor,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]..addAll(
              widget.todos.todoList.length != 0
                  ? Iterable.generate(widget.todos.todoList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
                        child: TodoTile(
                          title: widget.todos.groupName,
                          todo: widget.todos.todoList[index],
                          id: ids[index],
                          key: Key(
                            widget.todos.todoList[index].title,
                          ),
                        ),
                      );
                    })
                  : Iterable.generate(
                      1,
                      (v) => Text(
                        'No todos!',
                        key: Key(v.toString()),
                        style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
            ),
        ),
      ),
    );
  }
}
