import 'package:equatable/equatable.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';

abstract class IntroductionState extends Equatable {
  const IntroductionState();
}

class InitialIntroductionState extends IntroductionState {
  @override
  List<Object> get props => [];
}

class AppStarted extends IntroductionState {
  @override
  List<Object> get props => [];
}

class LoadedState extends IntroductionState {
  final SettingsModel settingsModel;

  LoadedState(this.settingsModel);

  @override
  List<Object> get props => [settingsModel];
}

class IntroduceApp extends IntroductionState {
  @override
  List<Object> get props => [];
}

class EnterOrIntroduceState extends IntroductionState {
  @override
  List<Object> get props => [];
}
