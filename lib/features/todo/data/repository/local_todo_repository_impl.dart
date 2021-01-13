import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/datasource/todo_local_datasource.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';

class LocalTODORepositoryImpl extends LocalTODORepository {
  final TODOLocalDatasourceImpl _todoLocalDatasourceImpl;

  LocalTODORepositoryImpl(this._todoLocalDatasourceImpl);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() call) async {
    try {
      final result = await call();

      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Something went wrong!'));
    }
  }

  @override
  Either<Failure, List<TODOGroupModel>> getTODO() {
    // Its not async
    try {
      final result = _todoLocalDatasourceImpl.getCurrentTODO();

      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Something went wrong!'));
    }
  }

  @override
  Future<Either<Failure, void>> setTODO(List<TODOGroupModel> params) async {
    return _handleCalls<void>(
        () => _todoLocalDatasourceImpl.setCurrentTODO(params));
  }
}
