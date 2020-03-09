import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';

class IntroductionPage extends StatelessWidget {
  final IntroductionBloc bloc;

  IntroductionPage(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 250,
        child: FlareActor(
          'assets/animations/Logo.flr',
          animation: 'animation',
          color: Colors.black,
          fit: BoxFit.cover,
          callback: (value) {
            BlocProvider.of<IntroductionBloc>(context).add(EnterOrIntroduce());
          },
        ),
      ),
    );
  }
}
