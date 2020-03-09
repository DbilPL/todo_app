import 'package:equatable/equatable.dart';

abstract class IntroductionState extends Equatable {
  const IntroductionState();
}

class InitialIntroductionState extends IntroductionState {
  @override
  List<Object> get props => [];
}

class IntroduceAppState extends IntroductionState {
  @override
  List<Object> get props => [];
}

class HowAppWorksState extends IntroductionState {
  @override
  List<Object> get props => [];
}
