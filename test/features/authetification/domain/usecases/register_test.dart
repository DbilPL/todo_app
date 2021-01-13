import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';
import 'package:todoapp/features/authetification/domain/usecases/register.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in.dart';

class MockAuthRepository extends Mock implements FirebaseAuthRepository {}

void main() {
  MockAuthRepository mockAuthRepository;
  Register usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = Register(mockAuthRepository);
  });

  const UsualUserModel user = UsualUserModel(
    email: 'wow',
    password: 'yay',
    uid: 'yayayayay',
  );

  final AuthParams params = AuthParams(user.email, user.password);

  test('Should register with Firebase using repository', () async {
    when(mockAuthRepository.register(
            email: user.email, password: user.password))
        .thenAnswer((_) async => Right(user));

    final result = await usecase(params);

    expect(result, Right(user));

    verify(mockAuthRepository.register(
        email: user.email, password: user.password));

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
