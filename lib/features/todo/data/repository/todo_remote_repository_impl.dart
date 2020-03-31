import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/datasource/todo_remote_datasource.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/remote_todo_repository.dart';

class TodoRemoteRepositoryImpl extends RemoteTODORepository {
  final TodoRemoteDatasourceImpl repositoryImpl;

  TodoRemoteRepositoryImpl(this.repositoryImpl);

  @override
  Future<Either<Failure, List<TODOGroupModel>>> getTODO(String uid) async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final result = await repositoryImpl.getCurrentTODO(uid: uid);
        return Right(result);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else
      return Left(ConnectionFailure('You have not connection to internet!'));
  }

  @override
  Future<Either<Failure, void>> updateTODO(TODORemoteParams params) async {
    if (await DataConnectionChecker().hasConnection) {
      try {
        final success =
            repositoryImpl.updateCurrentTODO(params.list, uid: params.uid);

        return Right(success);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else
      return Left(ConnectionFailure('You have not connection to internet!'));
  }
}

class TODORemoteParams {
  final List<TODOGroupModel> list;

  final String uid;

  TODORemoteParams(this.list, this.uid);
}
