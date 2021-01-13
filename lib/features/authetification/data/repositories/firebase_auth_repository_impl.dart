import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/util/data/datasources/network_data_source.dart';
import 'package:todoapp/features/authetification/data/datasource/firebase_auth_datasource.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/repositories/firebase_auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  final FirebaseAuthDatasourceImpl _firebaseAuthDatasourceImpl;
  final NetworkDataSourceImpl _networkDataSourceImpl;

  FirebaseAuthRepositoryImpl(
      this._firebaseAuthDatasourceImpl, this._networkDataSourceImpl);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() call) async {
    if (await _networkDataSourceImpl.hasConnection()) {
      try {
        final result = await call();

        return Right(result);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else {
      return Left(ConnectionFailure(
          'You have no connection to internet! Check it and try again!'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return _handleCalls<void>(() => _firebaseAuthDatasourceImpl.signOut());
  }

  @override
  Future<Either<Failure, UsualUserModel>> signIn(
      {String email, String password}) async {
    return _handleCalls<UsualUserModel>(() =>
        _firebaseAuthDatasourceImpl.signIn(email: email, password: password));
  }

  @override
  Future<Either<Failure, UsualUserModel>> register(
      {String email, String password}) async {
    return _handleCalls<UsualUserModel>(() =>
        _firebaseAuthDatasourceImpl.register(email: email, password: password));
  }

  @override
  Future<Either<Failure, UsualUserModel>> signInAuto() async {
    return _handleCalls<UsualUserModel>(
        () => _firebaseAuthDatasourceImpl.signInAuto());
  }
}
