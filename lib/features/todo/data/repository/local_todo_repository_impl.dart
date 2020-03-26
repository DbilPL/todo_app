import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/datasource/todo_local_datasource.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';

class LocalTODORepositoryImpl extends LocalTODORepository {
  final TODOLocalDatasourceImpl todoLocalDatasourceImpl;

  LocalTODORepositoryImpl(this.todoLocalDatasourceImpl);

  @override
  Either<Failure, List<TODOGroupModel>> getTODO() {
    try {
      final todo = todoLocalDatasourceImpl.getCurrentTODO();
      return Right(todo);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setTODO(List<TODOGroupModel> params) async {
    try {
      final success = await todoLocalDatasourceImpl.setCurrentTODO(params);
      return Right(success);
    } catch (e) {
      print(e);
      return Left(CacheFailure('Something went wrong!'));
    }
  }
}
