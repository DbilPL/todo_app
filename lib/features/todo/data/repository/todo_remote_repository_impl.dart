import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/util/data/datasources/network_data_source.dart';
import 'package:todoapp/features/todo/data/datasource/todo_remote_datasource.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/remote_todo_repository.dart';

class TodoRemoteRepositoryImpl extends RemoteTODORepository {
  final TodoRemoteDatasourceImpl _dataSourceImpl;
  final NetworkDataSourceImpl _networkDataSourceImpl;

  TodoRemoteRepositoryImpl(this._dataSourceImpl, this._networkDataSourceImpl);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() call) async {
    if (await _networkDataSourceImpl.hasConnection()) {
      try {
        final result = await call();

        return Right(result);
      } catch (e) {
        return Left(FirebaseFailure('Something went wrong!'));
      }
    } else {
      return Left(ConnectionFailure('You have not connection to internet!'));
    }
  }

  @override
  Future<Either<Failure, List<TODOGroupModel>>> getTODO(String uid) async {
    return _handleCalls<List<TODOGroupModel>>(
        () => _dataSourceImpl.getCurrentTODO(uid: uid));
  }

  @override
  Future<Either<Failure, void>> updateTODO(TODORemoteParams params) async {
    return _handleCalls<void>(
        () => _dataSourceImpl.updateCurrentTODO(params.list));
  }
}

class TODORemoteParams {
  final List<TODOGroupModel> list;

  final String uid;

  TODORemoteParams(this.list, this.uid);
}
