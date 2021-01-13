import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/domain/repositories/remote_todo_repository.dart';

class GetRemoteTODO extends UseCase<List<TODOGroupModel>, String> {
  final RemoteTODORepository repository;

  GetRemoteTODO(this.repository);

  @override
  Future<Either<Failure, List<TODOGroupModel>>> call(String uid) async {
    return repository.getTODO(uid);
  }
}
