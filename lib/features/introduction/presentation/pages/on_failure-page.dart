import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';

class OnFailurePage extends StatefulWidget {
  @override
  _OnFailurePageState createState() => _OnFailurePageState();
}

class _OnFailurePageState extends State<OnFailurePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Something went wrong!',
            style: TextStyle(
              fontSize: 35,
              color: Theme.of(context).textTheme.caption.color,
            ),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<IntroductionBloc>(context).add(AppStart());
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              'Reload',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
