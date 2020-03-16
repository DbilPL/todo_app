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
    primaryColor: Colors.red,
    fontFamily: 'Raleway',
  );
  SettingsBloc(this._getCurrentSettings, this._setSettings);

  @override
  SettingsState get initialState => InitialSettingsState(settingsModelInitial);

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettings) {
      try {
        final settings = await _getCurrentSettings(NoParams());
        yield settings.fold((failure) {
          return CacheFailureState(settingsModelInitial);
        }, (settings) {
          return AlreadyRunned(settings);
        });
      } catch (e) {
        await _setSettings(settingsModelInitial);
        yield FirstRunState(settingsModelInitial);
      }
    }
  }
}
