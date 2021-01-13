import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkDataSource {
  Future<bool> hasConnection();
}

class NetworkDataSourceImpl extends NetworkDataSource {
  final DataConnectionChecker _connectionChecker;

  NetworkDataSourceImpl(this._connectionChecker);

  @override
  Future<bool> hasConnection() {
    return _connectionChecker.hasConnection;
  }
}
