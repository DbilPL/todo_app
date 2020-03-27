import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_list.dart';
import 'package:todoapp/features/todo/presentation/widgets/todo_modal_bottom_sheet_todo_group.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is CreateAccountToNoAccountUserState) {
            Navigator.of(context).pushReplacementNamed('/auth');
          }
          if (state is SignedOut) {
            Navigator.of(context).pushReplacementNamed('/auth');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          // ignore: missing_return
          builder: (context, state) {
            final isUserRegistered = isRegistered(context);

            if (state is Entered)
              return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  iconTheme: Theme.of(context).iconTheme,
                  title: Text(
                    'TODO',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                drawer: Drawer(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    child: ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(''),
                          accountEmail: Text(
                            isUserRegistered ? state.props[1] : 'Anoniymous',
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Settings',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.caption.color,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/settings');
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Delete all TODO',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.caption.color,
                            ),
                          ),
                          onTap: () {
                            isUserRegistered
                                ? (() {})()
                                : BlocProvider.of<TodoBloc>(context).add(
                                    DeleteAllTodoLocal(
                                        BlocProvider.of<TodoBloc>(context)
                                            .state
                                            .list,
                                        false),
                                  );

                            Navigator.of(context).pop();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: RaisedButton(
                            onPressed: () {
                              isUserRegistered
                                  ? BlocProvider.of<AuthBloc>(context)
                                      .add(SignOutEvent(state.user))
                                  : BlocProvider.of<AuthBloc>(context)
                                      .add(CreateAccountToNoAccountUser());
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              isUserRegistered ? 'Sign out' : 'Log in',
                              style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: BlocListener<TodoBloc, TodoState>(
                  listener: (context, state) {
                    if (state is FailureTodoState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    if (state is AreYouSureForDeletingAllTodo) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Are you sure?',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).backgroundColor,
                            elevation: 0.0,
                            content: Text(
                              'After deleting, you will not may to return all todos.',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              FlatButton(
                                color: Theme.of(context).backgroundColor,
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  final isUserRegistered =
                                      isRegistered(context);

                                  if (isUserRegistered) {
                                  } else
                                    BlocProvider.of<TodoBloc>(context).add(
                                        DeleteAllTodoLocal(
                                            BlocProvider.of<TodoBloc>(context)
                                                .state
                                                .list,
                                            true));
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                color: Theme.of(context).backgroundColor,
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: TodoList(),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return TodoModalBottomSheet();
                      },
                    );
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomAppBar(
                  color: Theme.of(context).primaryColor,
                  shape: CircularNotchedRectangle(),
                  child: Container(
                    height: 60,
                  ),
                ),
              );
            else
              Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
