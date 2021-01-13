import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

class SignOut extends UseCase<void, NoParams> {
  final FirebaseAuthRepository _repository;

  SignOut(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return _repository.signOut();
  }
}
