import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Settings extends Equatable {
  final Color backgroundColor, primaryColor, fontColor;

  final String fontFamily;

  Settings({
    @required this.backgroundColor,
    @required this.primaryColor,
    @required this.fontColor,
    @required this.fontFamily,
  });

  @override
  List<Object> get props =>
      [backgroundColor, primaryColor, fontColor, fontFamily];
}
