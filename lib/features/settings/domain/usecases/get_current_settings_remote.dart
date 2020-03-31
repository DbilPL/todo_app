import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/remote_settings_repository.dart';

class GetCurrentSettingsRemote extends UseCase<SettingsModel, String> {
  final RemoteSettingsRepository repositoryImpl;

  GetCurrentSettingsRemote(this.repositoryImpl);

  @override
  Future<Either<Failure, SettingsModel>> call(String uid) async {
    return await repositoryImpl.getCurrentSettings(uid);
  }
}
