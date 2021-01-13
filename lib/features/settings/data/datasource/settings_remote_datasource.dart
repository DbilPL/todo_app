import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/remote_settings_repository.dart';

abstract class SettingsRemoteDatasource {
  /// Uses [Firestore] to get current settings from database
  /// Returns [SettingsModel], if success, returns [FirebaseException] when something went wrong
  Future<SettingsModel> getCurrentSettings(String uid);

  /// Uses [Firestore] to write new settings on database
  /// Returns [FirebaseException] when something went wrong
  Future<void> setSettingsLocally(SetRemoteSettingsParams params);
}

class SettingsRemoteDatasourceImpl extends SettingsRemoteDatasource {
  final Firestore _firestore;

  SettingsRemoteDatasourceImpl(this._firestore);

  @override
  Future<SettingsModel> getCurrentSettings(String uid) async {
    final CollectionReference collection = _firestore.collection('settings');

    final document = collection.document(uid);

    final data = await document.get();

    final map = data.data;

    return SettingsModel.toSettings(map);
  }

  @override
  Future<void> setSettingsLocally(SetRemoteSettingsParams params) async {
    final collection = _firestore.collection('settings');

    final document = collection.document(params.uid);

    final map = params.settings.toJSON();

    return document.setData(map);
  }
}
