import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_event.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';

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
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
                TextFormField(
                  controller: _repeatPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Repeat password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
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
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
