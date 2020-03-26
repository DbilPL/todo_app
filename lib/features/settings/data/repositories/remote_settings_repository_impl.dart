import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/settings/data/datasource/settings_remote_datasource.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

import '../../domain/repositories/remote_settings_repository.dart';

class RemoteSettingsRepositoryImpl extends RemoteSettingsRepository {
  final SettingsRemoteDatasourceImpl datasourceImpl;

  RemoteSettingsRepositoryImpl(this.datasourceImpl);

  @override
  Future<Either<Failure, SettingsModel>> getCurrentSettings(String uid) async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final result = await datasourceImpl.getCurrentSettings(uid);

        return Right(result);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong'));
      }
    } else
      return Left(ConnectionFailure('You have not connection to internet!'));
  }

  @override
  Future<Either<Failure, void>> setSettings(
      SetRemoteSettingsParams params) async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final result = await datasourceImpl.setSettingsLocally(params);

        return Right(result);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong'));
      }
    } else
      return Left(ConnectionFailure('You have not connection to internet!'));
  }
}
