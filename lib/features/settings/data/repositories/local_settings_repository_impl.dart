import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/local_settings_repository.dart';

class LocalSettingsRepositoryImpl extends LocalSettingsRepository {
  final SettingsLocalDatasourceImpl localDatasourceImpl;

  LocalSettingsRepositoryImpl(this.localDatasourceImpl);

  @override
  Future<Either<Failure, SettingsModel>> getCurrentSettings() async {
    try {
      final settings = await localDatasourceImpl.getCurrentSettings();
      return Right(settings);
    } on CacheException {
      return Left(CacheFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, void>> setSettings(SettingsModel params) async {
    try {
      final set = await localDatasourceImpl.setSettings(params);
      return Right(set);
    } on CacheException {
      return Left(CacheFailure('Something went wrong'));
    }
  }
}
