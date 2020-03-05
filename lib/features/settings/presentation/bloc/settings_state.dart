import 'package:equatable/equatable.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class SettingsState extends Equatable {
  final SettingsModel settingsModel;

  const SettingsState(this.settingsModel);
}

class InitialSettingsState extends SettingsState {
  InitialSettingsState(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [];
}

abstract class FailureSettingsState extends SettingsState {
  const FailureSettingsState() : super(null);
}

class CacheFailureState extends FailureSettingsState {
  final String error;

  CacheFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class IntroductionAppState extends SettingsState {
  IntroductionAppState(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [];
}

class LoadedState extends SettingsState {
  LoadedState(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [];
}
