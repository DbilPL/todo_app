import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoapp/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  final Color backgroundColor, primaryColor, fontColor;

  final String fontFamily;

  SettingsModel({
    @required this.backgroundColor,
    @required this.primaryColor,
    @required this.fontColor,
    @required this.fontFamily,
  }) : super(
          backgroundColor: backgroundColor,
          primaryColor: primaryColor,
          fontColor: fontColor,
          fontFamily: fontFamily,
        );

  @override
  List<Object> get props =>
      [backgroundColor, primaryColor, fontColor, fontFamily];

  Map<String, dynamic> toJSON() {
    return {
      "fontFamily": fontFamily,
      "backgroundColor": [
        backgroundColor.red,
        backgroundColor.green,
        backgroundColor.blue,
      ],
      "primaryColor": [
        primaryColor.red,
        primaryColor.green,
        primaryColor.blue,
      ],
      "fontColor": [
        fontColor.red,
        fontColor.green,
        fontColor.blue,
      ],
    };
  }

  static SettingsModel toSettings(Map<String, dynamic> json) {
    return SettingsModel(
      fontFamily: json['fontFamily'],
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
      fontColor: Color.fromRGBO(
        json['fontColor'][0],
        json['fontColor'][1],
        json['fontColor'][2],
        1,
      ),
    );
  }
}
