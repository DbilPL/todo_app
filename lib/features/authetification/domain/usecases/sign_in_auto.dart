import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

class SignInAuto extends UseCase<UsualUserModel, NoParams> {
  final FirebaseAuthRepository repository;

  SignInAuto(this.repository);

  @override
  Future<Either<Failure, UsualUserModel>> call(NoParams params) async {
    return await repository.signInAuto();
  }
}
