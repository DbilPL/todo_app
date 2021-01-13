import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

class AuthParams {
  final String email, password;

  AuthParams(this.email, this.password);
}

class SignIn extends UseCase<UsualUserModel, AuthParams> {
  final FirebaseAuthRepository _repository;

  SignIn(this._repository);

  @override
  Future<Either<Failure, UsualUserModel>> call(AuthParams params) async {
    return _repository.signIn(password: params.password, email: params.email);
  }
}
