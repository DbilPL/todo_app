import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings_local.dart';

import 'get_current_settings_local_test.dart';

void main() {
  MockSettingsRepositoryLocal mockSettingsRepository;
  SetSettingsLocal usecase;

  setUp(() {
    mockSettingsRepository = MockSettingsRepositoryLocal();
    usecase = SetSettingsLocal(mockSettingsRepository);
  });

  final tSettings = SettingsModel(
    backgroundColor: Colors.white,
    primaryColor: Colors.red,
    fontColor: Colors.black,
    fontFamily: 'whyme',
  );

  test('Should set settings locally on device using repository', () async {
    when(mockSettingsRepository.setSettingsLocally(tSettings))
        .thenAnswer((_) async => Right(doSomething()));

    final result = await usecase(tSettings);

    expect(result, Right(doSomething()));
    verify(mockSettingsRepository.setSettingsLocally(tSettings));
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}

void doSomething() {}
