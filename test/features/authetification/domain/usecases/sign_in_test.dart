import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in.dart';

import 'register_test.dart';

void main() {
  MockAuthRepository mockAuthRepository;
  SignIn usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignIn(mockAuthRepository);
  });

  const UsualUserModel user = UsualUserModel(
    email: 'wow',
    password: 'yay',
    uid: 'yayayayay',
  );

  final AuthParams params = AuthParams(user.email, user.password);

  test('Should sign in with Firebase using repository', () async {
    when(mockAuthRepository.signIn(email: user.email, password: user.password))
        .thenAnswer((_) async => Right(user));

    final result = await usecase(params);

    expect(result, Right(user));

    verify(
        mockAuthRepository.signIn(email: user.email, password: user.password));

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
