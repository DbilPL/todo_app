import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

class SignInParams {
  final String email, password;

  SignInParams(this.email, this.password);
}

class SignIn extends UseCase<UsualUserModel, SignInParams> {
  final FirebaseAuthRepository repository;

  SignIn(this.repository);

  @override
  Future<Either<Failure, UsualUserModel>> call(params) async {
    return await repository.signIn(
        password: params.password, email: params.email);
  }
}
