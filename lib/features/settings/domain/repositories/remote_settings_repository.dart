import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class RemoteSettingsRepository {
  Future<Either<Failure, SettingsModel>> getCurrentSettings(String uid);

  Future<Either<Failure, void>> setSettings(SetRemoteSettingsParams params);
}

class SetRemoteSettingsParams {
  final String uid;

  final SettingsModel settings;

  SetRemoteSettingsParams(this.uid, this.settings);
}
