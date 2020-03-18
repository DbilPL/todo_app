import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

class Register extends UseCase<UsualUserModel, RegisterParams> {
  final FirebaseAuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, UsualUserModel>> call(params) {
    return repository.register(email: params.email, password: params.password);
  }
}

class RegisterParams {
  final String email, password;

  RegisterParams(this.email, this.password);
}
