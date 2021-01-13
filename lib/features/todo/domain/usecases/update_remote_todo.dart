import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/todo/data/repository/todo_remote_repository_impl.dart';
import 'package:todoapp/features/todo/domain/repositories/remote_todo_repository.dart';

class UpdateRemoteTODO extends UseCase<void, TODORemoteParams> {
  final RemoteTODORepository repository;

  UpdateRemoteTODO(this.repository);

  @override
  Future<Either<Failure, void>> call(TODORemoteParams params) async {
    return repository.updateTODO(params);
  }
}
