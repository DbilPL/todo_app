import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/todo/data/model/todo_global_model.dart';

abstract class LocalTODORepository {
  Either<Failure, TODOGModel> getTODO();

  Future<Either<Failure, void>> setTODO(TODOGModel params);
}
