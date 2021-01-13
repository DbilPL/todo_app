import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/local_settings_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

class MockSettingsRepositoryLocal extends Mock
    implements LocalSettingsRepository {}

void main() {
  GetCurrentSettingsLocal usecase;
  MockSettingsRepositoryLocal mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepositoryLocal();
    usecase = GetCurrentSettingsLocal(mockSettingsRepository);
  });

  const tSettings = SettingsModel(
    backgroundColor: Colors.white,
    primaryColor: Colors.red,
    fontColor: Colors.black,
    fontFamily: 'whyme',
  );
  test('Should set settings locally on device using repository', () async {
    when(mockSettingsRepository.getCurrentLocalSavedSettings())
        .thenAnswer((_) async => Right(tSettings));

    final result = await usecase(NoParams());

    expect(result, Right(tSettings));
    verify(mockSettingsRepository.getCurrentLocalSavedSettings());
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
