import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class LocalSettingsRepository {
  /// Returns saved settings
  Future<Either<Failure, SettingsModel>> getCurrentLocalSavedSettings();

  /// Sets up saved settings
  Future<Either<Failure, void>> setSettingsLocally(SettingsModel params);
}
