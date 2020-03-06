import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/datasource/todo_local_datasource.dart';
import 'package:todoapp/features/todo/data/model/todo_global_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';

class LocalTODODatasourceImpl extends LocalTODORepository {
  final TODOLocalDatasourceImpl todoLocalDatasourceImpl;

  LocalTODODatasourceImpl(this.todoLocalDatasourceImpl);

  @override
  Either<Failure, TODOGModel> getTODO() {
    try {
      final todo = todoLocalDatasourceImpl.getCurrentTODO();
      return Right(todo);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setTODO(TODOGModel params) async {
    try {
      return Right(await todoLocalDatasourceImpl.setCurrentTODO(params));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
