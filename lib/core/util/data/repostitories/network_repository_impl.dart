import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/util/data/datasources/network_data_source.dart';
import 'package:todoapp/core/util/domain/repositories/network_repository.dart';

import '../../../errors/failure.dart';

class NetworkRepositoryImpl extends NetworkRepository {
  final NetworkDataSource _networkDataSource;

  NetworkRepositoryImpl(this._networkDataSource);

  @override
  Future<Either<Failure, bool>> hasConnection() async {
    try {
      final result = await _networkDataSource.hasConnection();

      return Right(result);
    } catch (e) {
      return Left(
          Failure(error: 'Something went wrong with connection checker!'));
    }
  }
}
