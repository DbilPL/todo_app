import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/util/data/datasources/network_data_source.dart';
import 'package:todoapp/features/settings/data/datasource/settings_remote_datasource.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

import '../../domain/repositories/remote_settings_repository.dart';

class RemoteSettingsRepositoryImpl extends RemoteSettingsRepository {
  final SettingsRemoteDatasourceImpl _datasourceImpl;
  final NetworkDataSourceImpl _networkDataSourceImpl;

  RemoteSettingsRepositoryImpl(
      this._datasourceImpl, this._networkDataSourceImpl);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() call) async {
    if (await _networkDataSourceImpl.hasConnection()) {
      try {
        final result = await call();

        return Right(result);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong'));
      }
    } else {
      return Left(ConnectionFailure('You have not connection to internet!'));
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getCurrentSettings(String uid) async {
    return _handleCalls(() => _datasourceImpl.getCurrentSettings(uid));
  }

  @override
  Future<Either<Failure, void>> setSettings(
      SetRemoteSettingsParams params) async {
    return _handleCalls(() => _datasourceImpl.setSettingsLocally(params));
  }
}
