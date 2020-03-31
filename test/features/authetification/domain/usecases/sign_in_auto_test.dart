import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_auto.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

import 'register_test.dart';

void main() {
  MockAuthRepository mockAuthRepository;
  SignInAuto usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInAuto(mockAuthRepository);
  });

  final UsualUserModel user = UsualUserModel(
    email: 'wow',
    password: 'yay',
    uid: 'yayayayay',
  );

  test(
      'Should sign in auto using local saved data with Firebase using repository',
      () async {
    when(mockAuthRepository.signInAuto()).thenAnswer((_) async => Right(user));

    final result = await usecase(NoParams());

    expect(result, Right(user));

    verify(mockAuthRepository.signInAuto());

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
