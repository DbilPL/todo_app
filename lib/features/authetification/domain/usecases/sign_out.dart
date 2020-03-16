import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

class SignOut extends UseCase {
  final FirebaseAuthRepository repository;

  SignOut(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.signOut();
  }
}
