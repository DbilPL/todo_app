import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/local_settings_repository.dart';

class GetCurrentSettingsLocal extends UseCase<SettingsModel, NoParams> {
  final LocalSettingsRepository localSettingsRepository;

  GetCurrentSettingsLocal(this.localSettingsRepository);

  @override
  Future<Either<Failure, SettingsModel>> call(NoParams params) async =>
      localSettingsRepository.getCurrentLocalSavedSettings();
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
