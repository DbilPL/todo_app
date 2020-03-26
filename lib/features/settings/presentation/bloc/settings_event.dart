import 'package:equatable/equatable.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettingsLocalInitial extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class LoadSettingsLocal extends SettingsEvent {
  final SettingsModel prevSettings;

  LoadSettingsLocal(this.prevSettings);

  @override
  List<Object> get props => [prevSettings];
}

class LoadSettingsRemote extends SettingsEvent {
  final String uid;

  final SettingsModel prevSettings;

  LoadSettingsRemote(this.uid, this.prevSettings);

  @override
  List<Object> get props => [uid];
}

class SetSettingsRemoteEvent extends SettingsEvent {
  final String uid;
  final SettingsModel settings;
  final SettingsModel prevSettings;

  SetSettingsRemoteEvent(this.settings, this.prevSettings, this.uid);

  @override
  List<Object> get props => [settings, prevSettings, uid];
}

class SetSettingsLocalEvent extends SettingsEvent {
  final SettingsModel settings;
  final SettingsModel prevSettings;

  SetSettingsLocalEvent(this.settings, this.prevSettings);

  @override
  List<Object> get props => [settings, prevSettings];
}
