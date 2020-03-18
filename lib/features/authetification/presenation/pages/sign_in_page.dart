import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_event.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController;
  TextEditingController _passswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Entered) {
          _emailController.clear();
          _passswordController.clear();
        }
      },
      child: Column(
        children: <Widget>[
          Text(
            'Sign in',
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
                  controller: _passswordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignInEvent(
                  _emailController.text, _passswordController.text));
            },
            child: Text(
              'Sign in',
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            color: Theme.of(context).primaryColor,
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(EnterWithoutAccountEvent());
            },
            child: Text(
              'Enter without account',
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
            color: Theme.of(context).primaryColor,
          ),
          Text('If you have no account, create it. (swipe down)'),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
