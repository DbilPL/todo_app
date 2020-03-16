import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _emailController;
  TextEditingController _passswordController;
  TextEditingController _repeatPassswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passswordController = TextEditingController();
    _repeatPassswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Log in',
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
              TextFormField(
                controller: _repeatPassswordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Repeat password',
                  prefixIcon: Icon(Icons.vpn_key),
                ),
              ),
            ],
          ),
        ),
        RaisedButton(
          onPressed: () {},
          child: Text(
            'Create account',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
