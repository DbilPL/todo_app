import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/repository/local_todo_repository_impl.dart';

class GetLocalTodo extends UseCase<List<TODOGroupModel>, NoParams> {
  final LocalTODORepositoryImpl repositoryImpl;

  GetLocalTodo(this.repositoryImpl);

  @override
  Future<Either<Failure, List<TODOGroupModel>>> call(NoParams params) async {
    return await repositoryImpl.getTODO();
  }
}
