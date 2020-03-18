import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class FirebaseAuthRepository {
  // sing in with email & password
  Future<Either<Failure, UsualUserModel>> signIn(
      {String email, String password});
  // register with email & password
  Future<Either<Failure, UsualUserModel>> register(
      {String email, String password});
  // sign out
  Future<Either<Failure, void>> signOut();
  // auto enter
  Future<Either<Failure, UsualUserModel>> signInAuto();
}
