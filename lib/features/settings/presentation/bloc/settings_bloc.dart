import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/remote_settings_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_remote.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings_local.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings_remote.dart';

import 'bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetCurrentSettingsLocal _getCurrentSettingsLocal;
  final SetSettingsLocal _setSettingsLocal;

  final GetCurrentSettingsRemote _getCurrentSettingsRemote;
  final SetSettingsRemote _setSettingsRemote;

  final SettingsModel settingsModelInitial = SettingsModel(
    backgroundColor: Colors.white,
    primaryColor: Colors.red,
    fontColor: Colors.black,
    fontFamily: 'Raleway',
  );
  SettingsBloc(this._getCurrentSettingsLocal, this._setSettingsLocal,
      this._getCurrentSettingsRemote, this._setSettingsRemote);

  @override
  SettingsState get initialState => InitialSettingsState(settingsModelInitial);

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettingsLocalInitial) {
      try {
        final settings = await _getCurrentSettingsLocal(NoParams());
        yield await settings.fold((failure) async {
          final local = await _setSettingsLocal(settingsModelInitial);

          return local.fold((failure) {
            return CacheFailureState(settingsModelInitial);
          }, (success) {
            return FirstRunState(settingsModelInitial);
          });
        }, (settings) {
          return AlreadyRunned(settings);
        });
      } catch (e) {
        final local = await _setSettingsLocal(settingsModelInitial);

        yield local.fold((failure) {
          return CacheFailureState(settingsModelInitial);
        }, (success) {
          return FirstRunState(settingsModelInitial);
        });
      }
    }

    if (event is LoadSettingsLocal) {
      final prevSettings = event.prevSettings;

      yield LoadingSettingsState(prevSettings);

      try {
        final settings = await _getCurrentSettingsLocal(NoParams());
        yield settings.fold((failure) {
          return CacheFailureState(prevSettings);
        }, (seti) {
          return SettingsUpdated(seti);
        });
      } catch (e) {
        yield CacheFailureState(prevSettings);
      }
    }

    if (event is LoadSettingsRemote) {
      final prevSettings = event.prevSettings;

      yield LoadingSettingsState(prevSettings);
      try {
        final settings = await _getCurrentSettingsRemote(event.uid);

        yield await settings.fold((failure) async {
          return ConnectionFailureState(prevSettings);
        }, (settings) {
          return SettingsUpdated(settings);
        });
      } catch (e) {
        yield ConnectionFailureState(prevSettings);
      }
    }

    if (event is SetSettingsRemoteEvent) {
      final prevSettings = event.prevSettings;
      final settings = event.settings;

      yield LoadingSettingsState(prevSettings);

      try {
        final updateSettingsOrFailure = await _setSettingsRemote(
            SetRemoteSettingsParams(event.uid, settings));

        final setSettingsOrFailure = await _setSettingsLocal(settings);

        yield updateSettingsOrFailure.fold((failure) {
          return ConnectionFailureState(prevSettings);
        }, (success) {
          return setSettingsOrFailure.fold((failure) {
            return CacheFailureState(prevSettings);
          }, (success) {
            return SettingsUpdated(settings);
          });
        });
      } catch (e) {
        yield ConnectionFailureState(prevSettings);
      }
    }

    if (event is SetSettingsLocalEvent) {
      final prevSettings = event.prevSettings;
      final settings = event.settings;

      yield LoadingSettingsState(prevSettings);

      try {
        final saveSettingsOrFailure = await _setSettingsLocal(settings);

        yield saveSettingsOrFailure.fold((failure) {
          return CacheFailureState(prevSettings);
        }, (success) {
          return SettingsUpdated(settings);
        });
      } catch (e) {
        yield CacheFailureState(prevSettings);
      }
    }
  }
}
