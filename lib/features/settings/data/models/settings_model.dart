import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoapp/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  final Color backgroundColor, accentColor, primaryColor;

  final String fontFamily;

  SettingsModel({
    @required this.backgroundColor,
    @required this.accentColor,
    @required this.primaryColor,
    @required this.fontFamily,
  }) : super(
          backgroundColor: backgroundColor,
          accentColor: accentColor,
          primaryColor: primaryColor,
          fontFamily: fontFamily,
        );

  @override
  List<Object> get props =>
      [backgroundColor, accentColor, primaryColor, fontFamily];

  Map<String, dynamic> toJSON() {
    return {
      "fontFamily": fontFamily,
      "backgroundColor": [
        backgroundColor.red,
        backgroundColor.green,
        backgroundColor.blue,
      ],
      "accentColor": [
        accentColor.red,
        accentColor.green,
        accentColor.blue,
      ],
      "primaryColor": [
        primaryColor.red,
        primaryColor.green,
        primaryColor.blue,
      ],
    };
  }

  static SettingsModel toSettings(Map<String, dynamic> json) {
    print('here json! $json');

    return SettingsModel(
      fontFamily: json['fontFamily'],
      accentColor: Color.fromRGBO(
        json['accentColor'][0],
        json['accentColor'][1],
        json['accentColor'][2],
        1,
      ),
      backgroundColor: Color.fromRGBO(
        json['backgroundColor'][0],
        json['backgroundColor'][1],
        json['backgroundColor'][2],
        1,
      ),
      primaryColor: Color.fromRGBO(
        json['primaryColor'][0],
        json['primaryColor'][1],
        json['primaryColor'][2],
        1,
      ),
    );
  }
}
