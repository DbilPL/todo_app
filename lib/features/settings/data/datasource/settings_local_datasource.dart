import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class SettingsLocalDatasource {
  /// Uses [SharedPreferences] to get current settings
  /// Returns [SettingsModel], if success, returns [CacheException] when something went wrong
  SettingsModel getCurrentLocallySavedSettings();

  /// Uses [SharedPreferences] to write new settings locally
  /// Returns [CacheException] when something went wrong
  Future<void> setSettingsLocally(SettingsModel settingsModel);
}

const _settingsKey = 'settings';

class SettingsLocalDatasourceImpl extends SettingsLocalDatasource {
  final SharedPreferences _storage;

  SettingsLocalDatasourceImpl(this._storage);

  @override
  SettingsModel getCurrentLocallySavedSettings() {
    final settings = _storage.getString(_settingsKey);

    final map = json.decode(settings) as Map<String, dynamic>;

    return SettingsModel.toSettings(map);
  }

  @override
  Future<void> setSettingsLocally(SettingsModel settingsModel) async {
    final str = json.encode(
      settingsModel.toJSON(),
    );

    await _storage.setString(
      _settingsKey,
      str,
    );
  }
}
