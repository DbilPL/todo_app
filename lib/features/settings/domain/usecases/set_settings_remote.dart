import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/domain/repositories/remote_settings_repository.dart';

class SetSettingsRemote extends UseCase<void, SetRemoteSettingsParams> {
  final RemoteSettingsRepository remoteSettingsRepository;

  SetSettingsRemote(this.remoteSettingsRepository);

  @override
  Future<Either<Failure, void>> call(SetRemoteSettingsParams params) async {
    return await remoteSettingsRepository.setSettings(params);
  }
}
