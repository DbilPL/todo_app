import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class FirebaseAuthRepository {
  // sing in anon
  Future<Either<Failure, UserModel>> signInAnon();
  // sing in with email & password

  // register with email & password

  // sign out
  Future<Either<Failure, void>> signOut();
}
