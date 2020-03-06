import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';
import 'package:todoapp/features/todo/data/model/todo_global_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';

class GetTODO extends UseCase<TODOGModel, NoParams> {
  final LocalTODORepository localTODORepository;

  GetTODO(this.localTODORepository);

  @override
  Future<Either<Failure, TODOGModel>> call(NoParams params) async {
    return localTODORepository.getTODO();
  }
}
