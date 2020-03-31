import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/domain/repositories/remote_settings_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings_remote.dart';

import 'get_current_settings_remote_test.dart';

void main() {
  SetSettingsRemote usecase;
  MockSettingsRepositoryRemote mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepositoryRemote();
    usecase = SetSettingsRemote(mockSettingsRepository);
  });

  final tSettings = SettingsModel(
    backgroundColor: Colors.white,
    primaryColor: Colors.red,
    fontColor: Colors.black,
    fontFamily: 'whyme',
  );

  final String uid = 'toookeeeen';

  final SetRemoteSettingsParams params =
      SetRemoteSettingsParams(uid, tSettings);

  test('Should set settings on Firebase using repository', () async {
    when(mockSettingsRepository.setSettings(params))
        .thenAnswer((_) async => Right(tSettings));

    final result = await usecase(params);

    expect(result, Right(tSettings));
    verify(mockSettingsRepository.setSettings(params));
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
