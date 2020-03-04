import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Settings extends Equatable {
  final Color backgroundColor, accentColor, primaryColor;

  Settings(
      {@required this.backgroundColor,
      @required this.accentColor,
      @required this.primaryColor});

  @override
  List<Object> get props => [backgroundColor, accentColor, primaryColor];

  Map<String, dynamic> toJSON() {
    return {
      'backgroundColor':
          '${backgroundColor.red} ${backgroundColor.green} ${backgroundColor.blue}',
      'accentColor':
          '${accentColor.red} ${accentColor.green} ${accentColor.blue}',
      'primaryColor':
          '${primaryColor.red} ${primaryColor.green} ${primaryColor.blue}',
    };
  }
}
