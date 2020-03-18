import 'package:equatable/equatable.dart';

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

class IntroduceApp extends IntroductionState {
  @override
  List<Object> get props => [];
}

class EnterOrIntroduceState extends IntroductionState {
  @override
  List<Object> get props => [];
}
