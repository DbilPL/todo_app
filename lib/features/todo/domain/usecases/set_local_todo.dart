import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/repository/local_todo_repository_impl.dart';

class SetLocalTODO extends UseCase<void, List<TODOGroupModel>> {
  final LocalTODORepositoryImpl repositoryImpl;

  SetLocalTODO(this.repositoryImpl);
  @override
  Future<Either<Failure, void>> call(List<TODOGroupModel> params) async {
    return await repositoryImpl.setTODO(params);
  }
}
