import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/local_settings_repository.dart';

class LocalSettingsRepositoryImpl extends LocalSettingsRepository {
  final SettingsLocalDatasourceImpl localDatasourceImpl;

  LocalSettingsRepositoryImpl(this.localDatasourceImpl);

  @override
  Future<Either<Failure, SettingsModel>> getCurrentLocalSavedSettings() async {
    try {
      final settings = localDatasourceImpl.getCurrentLocallySavedSettings();
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, void>> setSettingsLocally(SettingsModel params) async {
    try {
      final set = await localDatasourceImpl.setSettingsLocally(params);
      return Right(set);
    } catch (e) {
      return Left(CacheFailure('Something went wrong'));
    }
  }
}
