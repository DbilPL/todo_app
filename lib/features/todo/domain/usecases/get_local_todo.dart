import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';

class GetLocalTodo extends UseCase<List<TODOGroupModel>, NoParams> {
  final LocalTODORepository repositoryImpl;

  GetLocalTodo(this.repositoryImpl);

  @override
  Future<Either<Failure, List<TODOGroupModel>>> call(NoParams params) async {
    return repositoryImpl.getTODO();
  }
}
