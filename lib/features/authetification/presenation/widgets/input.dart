import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final TextEditingController controller;

  final TextInputType textInputType;

  final String labelText;

  final Icon icon;

  final bool isObscure;

  const MyInput(
      {Key key,
      this.controller,
      this.textInputType,
      this.labelText,
      this.icon,
      this.isObscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).textTheme.caption.color,
      ),
      controller: controller,
      keyboardType: textInputType,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        prefixIcon: icon,
      ),
    );
  }
}
