import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class HowAppWorks extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class AppStarted extends SettingsEvent {
  @override
  List<Object> get props => [];
}
