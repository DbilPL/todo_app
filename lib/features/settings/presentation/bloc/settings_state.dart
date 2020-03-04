import 'package:equatable/equatable.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class InitialSettingsState extends SettingsState {
  @override
  List<Object> get props => [];
}

abstract class FailureSettingsState extends SettingsState {
  const FailureSettingsState();
}

class CacheFailureState extends FailureSettingsState {
  final String error;

  CacheFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class IntroductionAppState extends SettingsState {
  @override
  List<Object> get props => [];
}
