import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/remote_settings_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_remote.dart';

class MockSettingsRepositoryRemote extends Mock
    implements RemoteSettingsRepository {}

void main() {
  GetCurrentSettingsRemote usecase;
  MockSettingsRepositoryRemote mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepositoryRemote();
    usecase = GetCurrentSettingsRemote(mockSettingsRepository);
  });

  const tSettings = SettingsModel(
    backgroundColor: Colors.white,
    primaryColor: Colors.red,
    fontColor: Colors.black,
    fontFamily: 'whyme',
  );

  const String uid = 'toookeeeen';

  test('Should get settings from Firebase using repository', () async {
    when(mockSettingsRepository.getCurrentSettings(uid))
        .thenAnswer((_) async => Right(tSettings));

    final result = await usecase(uid);

    expect(result, Right(tSettings));
    verify(mockSettingsRepository.getCurrentSettings(uid));
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
