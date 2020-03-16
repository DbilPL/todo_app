import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class IntroductionBloc extends Bloc<IntroductionEvent, IntroductionState> {
  @override
  IntroductionState get initialState => InitialIntroductionState();

  @override
  Stream<IntroductionState> mapEventToState(
    IntroductionEvent event,
  ) async* {
    if (event is AppStart) {
      yield AppStarted();
    }
    if (event is EnterOrIntroduce) {
      yield EnterOrIntroduceState();
    }
    if (event is Introduce) {
      yield IntroduceApp();
    }
  }
}
