import 'package:todoapp/core/errors/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:todoapp/core/util/domain/repositories/network_repository.dart';

import '../../../../features/settings/domain/usecases/get_current_settings_local.dart';
import '../../../usecases/usecase.dart';

class HasConnection extends UseCase<bool, NoParams> {
  final NetworkRepository _repository;

  HasConnection(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.hasConnection();
  }
}
