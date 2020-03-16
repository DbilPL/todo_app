import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/authetification/data/datasource/firebase_auth_datasource.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthDatasourceImpl firebaseAuthDatasourceImpl;

  FirebaseAuthRepositoryImpl(this.firebaseAuthDatasourceImpl);

  @override
  Future<Either<Failure, UserModel>> signInAnon() async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final result = await firebaseAuthDatasourceImpl.signInAnon();
        if (result == null)
          return Left(FirebaseFailure('Something went wrong!'));
        else
          return Right(UserModel(uid: result.uid));
      } catch (e) {
        return Left(FirebaseFailure(e.toString()));
      }
    } else
      return Left(FirebaseFailure('You have no connection to internet!'));
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        return Right(await firebaseAuthDatasourceImpl.signOut());
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else
      return Left(FirebaseFailure('You have no connection to internet!'));
  }
}
