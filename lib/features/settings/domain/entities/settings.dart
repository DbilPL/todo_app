import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Settings extends Equatable {
  final Color backgroundColor, accentColor, primaryColor, fontColor;

  final String fontFamily;

  Settings({
    @required this.backgroundColor,
    @required this.accentColor,
    @required this.primaryColor,
    @required this.fontColor,
    @required this.fontFamily,
  });

  @override
  List<Object> get props =>
      [backgroundColor, accentColor, primaryColor, fontColor, fontFamily];
}
