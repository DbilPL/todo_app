import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/authetification/presenation/pages/log_in_page.dart';
import 'package:todoapp/features/authetification/presenation/pages/sign_in_page.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todoapp/features/todo/presentation/bloc/todo_event.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is LoadingSettingsState)
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          if (state is ConnectionFailureState || state is CacheFailureState) {
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Something went wrong with settings!',
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          if (state is SettingsUpdated) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/todo');
          }
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, state) async {
            if (state is Entered) {
              final isUserRegistered = isRegistered(context);

              if (isUserRegistered) {
                if (state.typeOf == 'register') {
                  BlocProvider.of<SettingsBloc>(context).add(
                    SetSettingsRemoteEvent(
                      uid: state.user.props[0],
                      prevSettings: BlocProvider.of<SettingsBloc>(context)
                          .state
                          .settingsModel,
                      settings: BlocProvider.of<SettingsBloc>(context)
                          .state
                          .settingsModel,
                    ),
                  );

                  BlocProvider.of<TodoBloc>(context).add(SetRemoteTodoInitial(
                    BlocProvider.of<TodoBloc>(context).state.list,
                    state.user.props[0],
                    BlocProvider.of<TodoBloc>(context).state.list,
                  ));
                } else if (state.typeOf == 'sign in') {
                  BlocProvider.of<SettingsBloc>(context).add(
                    LoadSettingsRemote(
                      uid: state.user.props[0],
                      prevSettings: BlocProvider.of<SettingsBloc>(context)
                          .state
                          .settingsModel,
                    ),
                  );

                  BlocProvider.of<TodoBloc>(context).add(
                    LoadRemoteTodoInitial(
                      BlocProvider.of<TodoBloc>(context).state.list,
                      state.user.props[0],
                    ),
                  );
                }
              } else
                Navigator.of(context).pushReplacementNamed('/todo');
            }

            if (state is AreYouSureForEnteringWithoutAccount) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Are you sure?',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).backgroundColor,
                    elevation: 0.0,
                    content: Text(
                      'You have connection to internet! If you will continue, your TODO will not save on cloud!',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.caption.color,
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
                          BlocProvider.of<AuthBloc>(context)
                              .add(EnterWithoutAccountEvent(true));
                        },
                      ),
                      FlatButton(
                        color: Theme.of(context).backgroundColor,
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.caption.color,
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

            if (state is FailureState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failure,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }

            if (state is FirebaseFailureState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failure,
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is InputFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failure + ' Try again!',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is LoadingState)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            else
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      SignInPage(),
                      LogInPage(),
                    ],
                  ),
                ),
              );
          }),
        ),
      ),
    );
  }
}
