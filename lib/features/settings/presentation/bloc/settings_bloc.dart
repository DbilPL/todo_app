import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings.dart';

import 'bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetCurrentSettings _getCurrentSettings;
  final SetSettings _setSettings;
  SettingsBloc(this._getCurrentSettings, this._setSettings);

  @override
  SettingsState get initialState => InitialSettingsState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is AppStarted) {
      print('app started');

      final settings = await _getCurrentSettings(NoParams());

      yield settings.fold((failure) {
        print(failure.error);
        return CacheFailureState('Something went wrong!');
      }, (settings) {
        return IntroductionAppState();
      });
    }
  }
}
