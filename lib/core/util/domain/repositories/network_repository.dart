import 'package:dartz/dartz.dart';

import '../../../errors/failure.dart';

abstract class NetworkRepository {
  Future<Either<Failure, bool>> hasConnection();
}
