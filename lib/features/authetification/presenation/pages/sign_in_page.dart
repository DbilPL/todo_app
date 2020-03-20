import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_event.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';
import 'package:todoapp/features/authetification/presenation/widgets/input.dart';

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
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                MyInput(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                  textInputType: TextInputType.emailAddress,
                  isObscure: false,
                ),
                MyInput(
                  controller: _passswordController,
                  labelText: 'Password',
                  icon: Icon(Icons.vpn_key),
                  textInputType: TextInputType.visiblePassword,
                  isObscure: true,
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
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            color: Theme.of(context).primaryColor,
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(EnterWithoutAccountEvent(false));
            },
            child: Text(
              'Enter without account',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
            color: Theme.of(context).primaryColor,
          ),
          Text(
            'If you have no account, create it. (swipe down)',
            style: TextStyle(
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).textTheme.caption.color,
          ),
        ],
      ),
    );
  }
}
