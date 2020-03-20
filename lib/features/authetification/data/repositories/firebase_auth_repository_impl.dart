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
  Future<Either<Failure, void>> signOut() async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        return Right(await firebaseAuthDatasourceImpl.signOut());
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else
      return Left(ConnectionFailure(
          'You have no connection to internet! Check it and try again!'));
  }

  @override
  Future<Either<Failure, UsualUserModel>> signIn(
      {String email, String password}) async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final UsualUserModel user = await firebaseAuthDatasourceImpl.signIn(
            email: email, password: password);

        return Right(user);
      } catch (e) {
        return Left(FirebaseFailure('Wrong email or password!'));
      }
    } else
      return Left(ConnectionFailure(
          'You have no connection to internet! Check it and try again!'));
  }

  @override
  Future<Either<Failure, UsualUserModel>> register(
      {String email, String password}) async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final UsualUserModel user = await firebaseAuthDatasourceImpl.register(
            email: email, password: password);

        return Right(user);
      } catch (e) {
        return Left(FirebaseFailure(
            'Something went wrong! (Maybe account with this params already exists)'));
      }
    } else
      return Left(ConnectionFailure(
          'You have no connection to internet! Check it and try again!'));
  }

  @override
  Future<Either<Failure, UsualUserModel>> signInAuto() async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final UsualUserModel user =
            await firebaseAuthDatasourceImpl.signInAuto();

        return Right(user);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else
      return Left(
          ConnectionFailure('You have not connection to the internet!'));
  }
}
