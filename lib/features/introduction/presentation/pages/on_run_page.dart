import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class OnRunPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 36.0, top: 30.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.7,
            child: FlareActor(
              'assets/animations/Logo.flr',
              animation: 'animation',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
