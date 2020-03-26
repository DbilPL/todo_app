import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/repository/todo_remote_repository_impl.dart';

abstract class RemoteTODORepository {
  Future<Either<Failure, List<TODOGroupModel>>> getTODO(String uid);

  Future<Either<Failure, void>> updateTODO(TODORemoteParams params);
}
