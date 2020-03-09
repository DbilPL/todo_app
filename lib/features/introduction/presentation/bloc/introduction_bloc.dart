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
    if (event is IntroduceApp) {
      yield IntroduceAppState();
    }
    if (state is EnterOrIntroduce) {
      print('yay');
      yield HowAppWorksState();
    }
  }
}
