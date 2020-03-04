import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

///// Uses [FlutterSecureStorage] to get count of times, when user entered
///// Returns [int], if success, returns [CacheException] when something went wrong
//Future<int> timesOfEnter();
//
///// Uses [FlutterSecureStorage] to increase count of times, when user entered
///// Returns [int], if success, returns [CacheException] when something went wrong
//Future<int> increaseTimesOfEnter();
//
///// Uses [FlutterSecureStorage] to get [TODOModel] list of list
///// Returns list of them, if success, returns [CacheException] when something went wrong
//Future<List<List<TODOModel>>> getTODOList();
//
///// Uses [FlutterSecureStorage] to write [TODOModel] list of list on local cache
///// Returns [CacheException] when something went wrong
//Future<void> writeTODOList(List<List<TODOModel>> todos);

abstract class SettingsLocalDatasource {
  /// Uses [FlutterSecureStorage] to get current settings
  /// Returns [SettingsModel], if success, returns [CacheException] when something went wrong
  Future<SettingsModel> getCurrentSettings();

  /// Uses [FlutterSecureStorage] to write new settings locally
  /// Returns [CacheException] when something went wrong
  Future<void> setSettings(SettingsModel settingsModel);
}

const SETTINGS_KEY = 'settings';

class SettingsLocalDatasourceImpl extends SettingsLocalDatasource {
  final FlutterSecureStorage storage;

  SettingsLocalDatasourceImpl(this.storage);

  @override
  Future<SettingsModel> getCurrentSettings() async {
    final settings = await storage.read(key: SETTINGS_KEY);
    return SettingsModel.toSettings(jsonDecode(settings));
  }

  @override
  Future<void> setSettings(SettingsModel settingsModel) async {
    await storage.write(
        key: SETTINGS_KEY, value: settingsModel.toJSON().toString());
  }
}
