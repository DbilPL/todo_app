import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings.dart';

import 'bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetCurrentSettings _getCurrentSettings;
  final SetSettings _setSettings;
  final SettingsModel settingsModelInitial = SettingsModel(
      backgroundColor: Colors.white,
      accentColor: Colors.redAccent,
      primaryColor: Colors.red);
  SettingsBloc(this._getCurrentSettings, this._setSettings);

  @override
  SettingsState get initialState => InitialSettingsState(settingsModelInitial);

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is AppStarted) {
      print('app started');

      try {
        final settingsOrFailure = await _getCurrentSettings(NoParams());
        yield settingsOrFailure.fold((failure) {
          print(failure.error);
          return CacheFailureState('Something went wrong!');
        }, (settings) {
          print(settings == null);
          return LoadedState(settings);
        });
      } catch (e) {
        print(e);
        try {
          final setSettingsOrFailure = await _setSettings(settingsModelInitial);

          yield setSettingsOrFailure.fold((failure) {
            return CacheFailureState('Something went wrong!');
          }, (success) {
            return IntroductionAppState(settingsModelInitial);
          });
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }
}
