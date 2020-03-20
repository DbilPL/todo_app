import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';

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
            if (state is Entered) {
              if (state.user is UsualUserModel) {
                return Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  appBar: AppBar(
                    elevation: 0.0,
                    iconTheme: Theme.of(context).iconTheme,
                    title: Text(
                      'TODO',
                      style: TextStyle(
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                  drawer: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is Entered) {
                        if (state.error != null) {
                          Navigator.of(context).pop();
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
                      }
                    },
                    child: Drawer(
                      elevation: 0.0,
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: ListView(
                          children: <Widget>[
                            UserAccountsDrawerHeader(
                              accountName: Text(''),
                              accountEmail: Text(
                                state.user.props[1],
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Settings',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
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
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              ),
                              onTap: () {},
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: RaisedButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(SignOutEvent(state.user));
                                },
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  'Sign out',
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
                  ),
                );
              } else {
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
                              'Anoniymous',
                              style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Settings',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
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
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                            onTap: () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: RaisedButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(CreateAccountToNoAccountUser());
                              },
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                'Create account',
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
                );
              }
            } else
              return Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          },
        ),
      ),
    );
  }
}
