import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class AppStarted extends SettingsEvent {
  @override
  List<Object> get props => [];
}
