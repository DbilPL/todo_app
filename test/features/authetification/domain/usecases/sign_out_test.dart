import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_out.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

import '../../../settings/domain/usecases/set_settings_local_test.dart';
import 'register_test.dart';

void main() {
  MockAuthRepository mockAuthRepository;
  SignOut usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignOut(mockAuthRepository);
  });

  test('Should sign out with Firebase using repository', () async {
    when(mockAuthRepository.signOut())
        .thenAnswer((_) async => Right(doSomething()));

    final result = await usecase(NoParams());

    expect(result, Right(doSomething()));

    verify(mockAuthRepository.signOut());

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
