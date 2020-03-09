import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/core/errors/failure.dart';

abstract class FirebaseAuthRepository {
  // sing in anon
  Future<Either<Failure, FirebaseUser>> signInAnon();
  // sing in with email & password

  // register with email & password

  // sign out
}
