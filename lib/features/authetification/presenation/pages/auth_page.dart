import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/authetification/presenation/pages/log_in_page.dart';
import 'package:todoapp/features/authetification/presenation/pages/sign_in_page.dart';

import '../../../../injection_container.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, state) {
            if (state is SignedIn) {
              // Navigator.of(context).pushReplacementNamed('/todo_page');
            }
            if (state is FirebaseFailureState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.failure + ' Try again later!',
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: SafeArea(
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
          ),
        ),
      ),
    );
  }
}
