import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/authetification/presenation/pages/log_in_page.dart';
import 'package:todoapp/features/authetification/presenation/pages/sign_in_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, state) {
          if (state is Entered) {
            Navigator.of(context).pushReplacementNamed('/todo');
          }

          if (state is FailureState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failure + ' Enter your data!',
                  style: TextStyle(color: Theme.of(context).backgroundColor),
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
                  state.failure + ' Try again!',
                  style: TextStyle(color: Theme.of(context).backgroundColor),
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
                  style: TextStyle(color: Theme.of(context).backgroundColor),
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
              child: CircularProgressIndicator(),
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
    );
  }
}
