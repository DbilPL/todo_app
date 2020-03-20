import 'package:flutter/material.dart';

class FontViewer extends StatelessWidget {
  final String font;

  final Function onTap;

  const FontViewer({Key key, this.font, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              font,
              style: TextStyle(
                fontFamily: font,
                color: Theme.of(context).textTheme.caption.color,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
