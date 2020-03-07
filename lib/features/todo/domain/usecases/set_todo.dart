import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';

class SetTODO extends UseCase<void, List<TODOGroupModel>> {
  final LocalTODORepository localTODORepository;

  SetTODO(this.localTODORepository);

  @override
  Future<Either<Failure, void>> call(List<TODOGroupModel> params) async {
    return await localTODORepository.setTODO(params);
  }
}
