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
      try {
        final settings = await _getCurrentSettingsLocal(NoParams());
        yield settings.fold((failure) {
          return CacheFailureState(event.prevSettings);
        }, (settings) {
          return SettingsUpdated(settings);
        });
      } catch (e) {
        yield CacheFailureState(event.prevSettings);
      }
    }

    if (event is LoadSettingsRemote) {
      yield LoadingSettingsState(event.prevSettings);

      try {
        final settings = await _getCurrentSettingsRemote(event.uid);

        yield await settings.fold((failure) async {
          return ConnectionFailureState(event.prevSettings);
        }, (settings) {
          return SettingsUpdated(settings);
        });
      } catch (e) {
        final setSettings = await _setSettingsRemote(
            SetRemoteSettingsParams(event.uid, event.prevSettings));

        yield await setSettings.fold((failure) {
          return ConnectionFailureState(event.prevSettings);
        }, (success) async {
          final settings = await _getCurrentSettingsRemote(event.uid);

          return settings.fold((failure) {
            return ConnectionFailureState(event.prevSettings);
          }, (settings) {
            return SettingsUpdated(settings);
          });
        });
      }
    }

    if (event is SetSettingsRemoteEvent) {
      yield LoadingSettingsState(event.prevSettings);

      try {
        final updateSettingsOrFailure = await _setSettingsRemote(
            SetRemoteSettingsParams(event.uid, event.settings));

        yield updateSettingsOrFailure.fold((failure) {
          return ConnectionFailureState(event.prevSettings);
        }, (success) {
          return SettingsUpdated(event.settings);
        });
      } catch (e) {
        yield ConnectionFailureState(event.prevSettings);
      }
    }

    if (event is SetSettingsLocalEvent) {
      try {
        final saveSettingsOrFailure = await _setSettingsLocal(event.settings);

        yield saveSettingsOrFailure.fold((failure) {
          return CacheFailureState(event.prevSettings);
        }, (success) {
          return SettingsUpdated(event.settings);
        });
      } catch (e) {
        yield CacheFailureState(event.prevSettings);
      }
    }
  }
}
