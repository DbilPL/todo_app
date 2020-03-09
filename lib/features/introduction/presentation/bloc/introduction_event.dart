import 'package:equatable/equatable.dart';

abstract class IntroductionEvent extends Equatable {
  const IntroductionEvent();
}

class IntroduceApp extends IntroductionEvent {
  @override
  List<Object> get props => [];
}

class EnterOrIntroduce extends IntroductionEvent {
  @override
  List<Object> get props => [];
}
