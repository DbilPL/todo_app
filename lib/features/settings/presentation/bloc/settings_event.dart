import 'package:equatable/equatable.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettings extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class SetSettingsEvent extends SettingsEvent {
  final SettingsModel settings;
  final SettingsModel prevSettings;

  SetSettingsEvent(this.settings, this.prevSettings);

  @override
  List<Object> get props => [settings, prevSettings];
}
