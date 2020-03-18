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
          if (state is FirebaseFailureState) {}
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Entered) {
              print(state.user is UsualUserModel);
              if (state.user is UsualUserModel) {
                return Scaffold(
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(''),
                          accountEmail: Text(state.user.email),
                        ),
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(SignOutEvent());
                          },
                          child: Text('Sign out'),
                        ),
                      ],
                    ),
                  ),
                );
              } else
                return Scaffold(
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(CreateAccountToNoAccountUser());
                          },
                          child: Text('Create account'),
                        ),
                      ],
                    ),
                  ),
                );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}
