import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/authetification/data/datasource/remote_firebase_auth_datasource.dart';
import 'package:todoapp/features/authetification/domain/repositories/remote_firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthDatasourceImpl firebaseAuthDatasourceImpl;

  FirebaseAuthRepositoryImpl(this.firebaseAuthDatasourceImpl);

  @override
  Future<Either<Failure, FirebaseUser>> signInAnon() async {
    try {
      return Right(await firebaseAuthDatasourceImpl.signInAnon());
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }
}
