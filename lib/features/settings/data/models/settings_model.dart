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
    print('to json');

    return {
      "fontFamily": this.fontFamily,
      "backgroundColor": [
        this.backgroundColor.red,
        this.backgroundColor.green,
        this.backgroundColor.blue,
      ],
      "primaryColor": [
        this.primaryColor.red,
        this.primaryColor.green,
        this.primaryColor.blue,
      ],
      "fontColor": [
        this.fontColor.red,
        this.fontColor.green,
        this.fontColor.blue,
      ],
    };
  }

  static SettingsModel toSettings(Map<String, dynamic> json) {
    print(json);

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
