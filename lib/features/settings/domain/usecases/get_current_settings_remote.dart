import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/data/repositories/remote_settings_repository_impl.dart';

class GetCurrentSettingsRemote extends UseCase<SettingsModel, String> {
  final RemoteSettingsRepositoryImpl repositoryImpl;

  GetCurrentSettingsRemote(this.repositoryImpl);

  @override
  Future<Either<Failure, SettingsModel>> call(String uid) async {
    return await repositoryImpl.getCurrentSettings(uid);
  }
}
