import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_event.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';
import 'package:todoapp/features/authetification/presenation/widgets/input.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _repeatPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Entered) {
          _repeatPasswordController.clear();
          _passwordController.clear();
          _emailController.clear();
        }
      },
      child: Column(
        children: <Widget>[
          Text(
            'Creating account',
            style: TextStyle(
              fontSize: 35,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                MyInput(
                  isObscure: false,
                  textInputType: TextInputType.emailAddress,
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                  controller: _emailController,
                ),
                MyInput(
                  isObscure: true,
                  textInputType: TextInputType.visiblePassword,
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Password',
                  controller: _passwordController,
                ),
                MyInput(
                  isObscure: true,
                  textInputType: TextInputType.visiblePassword,
                  icon: Icon(Icons.vpn_key),
                  labelText: 'Repeat password',
                  controller: _repeatPasswordController,
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                _emailController.text,
                _passwordController.text,
                _repeatPasswordController.text,
              ));
            },
            child: Text(
              'Create account',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
