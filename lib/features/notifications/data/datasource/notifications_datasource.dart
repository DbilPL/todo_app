import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoapp/features/notifications/data/models/notifications_model.dart';

abstract class LocalNotificationsDatasource {
  /// Uses [FlutterLocalNotificationsPlugin] to set notification schedule in concrete time
  /// Returns [Exception] if something went wrong
  Future<void> setNotification(NotificationModel params);

  /// Uses [FlutterLocalNotificationsPlugin] to cancel concrete notification by ID
  /// Returns [Exception] if something went wrong
  Future<void> cancelNotification(int params);

  /// Uses [FlutterLocalNotificationsPlugin] to cancel all notifications
  /// Returns [Exception] if something went wrong
  Future<void> cancelAllNotifications();
}

class LocalNotificationsDatasourceImpl extends LocalNotificationsDatasource {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalNotificationsDatasourceImpl(this._flutterLocalNotificationsPlugin) {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String params) async {},
    );
  }

  static final AndroidNotificationDetails _androidDetails =
      AndroidNotificationDetails(
    'Todo App',
    'Notifications',
    'For your todos',
    sound: 'eventually',
    importance: Importance.Max,
    priority: Priority.High,
    color: Colors.white,
    largeIcon: 'app_icon',
    ledOnMs: 1000,
    ledOffMs: 1000,
    style: AndroidNotificationStyle.BigText,
  );

  static final IOSNotificationDetails _iosDetails = IOSNotificationDetails(
      sound: "slow_spring_board.aiff", presentSound: true);

  final NotificationDetails _notificationDetails = NotificationDetails(
    _androidDetails,
    _iosDetails,
  );

  @override
  Future<void> cancelNotification(int params) async {
    await _flutterLocalNotificationsPlugin.cancel(params);
  }

  @override
  Future<void> setNotification(NotificationModel params) async {
    await _flutterLocalNotificationsPlugin.schedule(
      params.id,
      'There is TODO to complete!',
      'Title: ${params.data.title}, body: ${params.data.body}',
      params.data.date,
      _notificationDetails,
      payload: jsonEncode(params.data.toJson()),
    );
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
