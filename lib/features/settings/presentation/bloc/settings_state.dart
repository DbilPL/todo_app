import 'package:equatable/equatable.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class SettingsState extends Equatable {
  final SettingsModel settingsModel;

  const SettingsState(this.settingsModel);
}

class InitialSettingsState extends SettingsState {
  InitialSettingsState(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [settingsModel];
}

class FirstRunState extends SettingsState {
  FirstRunState(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [settingsModel];
}

class AlreadyRunned extends SettingsState {
  AlreadyRunned(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [settingsModel];
}

class CacheFailureState extends SettingsState {
  CacheFailureState(SettingsModel settingsModel) : super(settingsModel);

  @override
  List<Object> get props => [settingsModel];
}

abstract class FailureSettingsState extends SettingsState {
  const FailureSettingsState() : super(null);
}
