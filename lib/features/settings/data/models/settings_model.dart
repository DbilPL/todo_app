import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoapp/features/settings/domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel(
      {String fontFamily,
      Color backgroundColor,
      Color primaryColor,
      Color fontColor})
      : super(
          backgroundColor: backgroundColor,
          fontColor: fontColor,
          fontFamily: fontFamily,
          primaryColor: primaryColor,
        );

  @override
  List<Object> get props =>
      [backgroundColor, primaryColor, fontColor, fontFamily];

  Map<String, dynamic> toJSON() {
    return {
      'fontFamily': fontFamily,
      'backgroundColor': [
        backgroundColor.red,
        backgroundColor.green,
        backgroundColor.blue,
      ],
      'primaryColor': [
        primaryColor.red,
        primaryColor.green,
        primaryColor.blue,
      ],
      'fontColor': [
        fontColor.red,
        fontColor.green,
        fontColor.blue,
      ],
    };
  }

  factory SettingsModel.toSettings(Map<String, dynamic> json) {
    return SettingsModel(
      fontFamily: json['fontFamily'] as String,
      backgroundColor: Color.fromRGBO(
        json['backgroundColor'][0] as int,
        json['backgroundColor'][1] as int,
        json['backgroundColor'][2] as int,
        1,
      ),
      primaryColor: Color.fromRGBO(
        json['primaryColor'][0] as int,
        json['primaryColor'][1] as int,
        json['primaryColor'][2] as int,
        1,
      ),
      fontColor: Color.fromRGBO(
        json['fontColor'][0] as int,
        json['fontColor'][1] as int,
        json['fontColor'][2] as int,
        1,
      ),
    );
  }

  SettingsModel copyWith({
    Color backgroundColor,
    Color primaryColor,
    Color fontColor,
    String fontFamily,
  }) {
    return SettingsModel(
      fontColor: fontColor ?? this.fontColor,
      fontFamily: fontFamily ?? this.fontFamily,
      primaryColor: primaryColor ?? this.primaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
