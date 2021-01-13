import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

import 'sign_in.dart';

class Register extends UseCase<UsualUserModel, AuthParams> {
  final FirebaseAuthRepository _repository;

  Register(this._repository);

  @override
  Future<Either<Failure, UsualUserModel>> call(AuthParams params) {
    return _repository.register(email: params.email, password: params.password);
  }
}
