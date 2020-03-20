import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  final Color color;
  final Function onPressed;

  const ColorCircle({Key key, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.5),
          border: Border.all(
            color: Colors.grey,
            width: 0.6,
          ),
        ),
      ),
    );
  }
}
