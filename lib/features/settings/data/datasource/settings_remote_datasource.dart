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
  final Firestore firestore;

  SettingsRemoteDatasourceImpl(this.firestore);

  @override
  Future<SettingsModel> getCurrentSettings(String uid) async {
    final CollectionReference collection = firestore.collection('settings');

    final result = await collection.document(uid).get();

    final data = result.data;

    return SettingsModel.toSettings(data);
  }

  @override
  Future<void> setSettingsLocally(SetRemoteSettingsParams params) async {
    final CollectionReference collection = firestore.collection('settings');

    return await collection.document(params.uid).setData(
          params.settings.toJSON(),
        );
  }
}
