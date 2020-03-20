import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
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
  /// Uses [SharedPreferences] to get current settings
  /// Returns [SettingsModel], if success, returns [CacheException] when something went wrong
  SettingsModel getCurrentLocallySavedSettings();

  /// Uses [SharedPreferences] to write new settings locally
  /// Returns [CacheException] when something went wrong
  Future<void> setSettingsLocally(SettingsModel settingsModel);
}

const SETTINGS_KEY = 'settings';

class SettingsLocalDatasourceImpl extends SettingsLocalDatasource {
  final SharedPreferences storage;

  SettingsLocalDatasourceImpl(this.storage);

  @override
  SettingsModel getCurrentLocallySavedSettings() {
    final settings = storage.getString(SETTINGS_KEY);

    return SettingsModel.toSettings(json.decode(settings));
  }

  @override
  Future<void> setSettingsLocally(SettingsModel settingsModel) async {
    await storage.setString(
      SETTINGS_KEY,
      json.encode(
        settingsModel.toJSON(),
      ),
    );
  }
}
