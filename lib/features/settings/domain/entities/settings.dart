import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Settings extends Equatable {
  final Color backgroundColor, accentColor, primaryColor;

  final String fontFamily;

  Settings({
    @required this.backgroundColor,
    @required this.accentColor,
    @required this.primaryColor,
    @required this.fontFamily,
  });

  @override
  List<Object> get props =>
      [backgroundColor, accentColor, primaryColor, fontFamily];

  Map<String, dynamic> toJSON() {
    return {
      "fontFamily": fontFamily,
      'backgroundColor':
          '${backgroundColor.red} ${backgroundColor.green} ${backgroundColor.blue}',
      'accentColor':
          '${accentColor.red} ${accentColor.green} ${accentColor.blue}',
      'primaryColor':
          '${primaryColor.red} ${primaryColor.green} ${primaryColor.blue}',
    };
  }
}
