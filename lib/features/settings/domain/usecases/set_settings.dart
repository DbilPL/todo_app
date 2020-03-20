import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/local_settings_repository.dart';

class SetSettings extends UseCase<void, SettingsModel> {
  final LocalSettingsRepository localSettingsRepository;

  SetSettings(this.localSettingsRepository);

  @override
  Future<Either<Failure, void>> call(SettingsModel params) async {
    return await localSettingsRepository.setSettingsLocally(params);
  }
}
