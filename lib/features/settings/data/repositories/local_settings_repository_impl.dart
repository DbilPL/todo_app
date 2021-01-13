import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/local_settings_repository.dart';

class LocalSettingsRepositoryImpl extends LocalSettingsRepository {
  final SettingsLocalDatasourceImpl _localDatasourceImpl;

  LocalSettingsRepositoryImpl(this._localDatasourceImpl);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() call) async {
    try {
      final result = await call();

      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getCurrentLocalSavedSettings() async {
    return _handleCalls<SettingsModel>(() =>
        Future.value(_localDatasourceImpl.getCurrentLocallySavedSettings()));
  }

  @override
  Future<Either<Failure, void>> setSettingsLocally(SettingsModel params) async {
    return _handleCalls<void>(
        () => _localDatasourceImpl.setSettingsLocally(params));
  }
}
