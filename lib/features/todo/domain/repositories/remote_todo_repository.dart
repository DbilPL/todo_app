import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';

abstract class RemoteTODORepository {
  Either<Failure, List<TODOGroupModel>> getTODO();

  Future<Either<Failure, void>> updateTODO(List<TODOGroupModel> params);
}
