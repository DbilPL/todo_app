import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';

class SignInAnon extends UseCase<UserModel, NoParams> {
  final FirebaseAuthRepository _authRepository;

  SignInAnon(this._authRepository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await _authRepository.signInAnon();
  }
}
