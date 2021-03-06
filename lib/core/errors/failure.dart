import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String error;

  Failure({this.error});

  @override
  List<Object> get props => [error];
}

class CacheFailure extends Failure {
  final String error;

  CacheFailure(this.error);

  @override
  List<Object> get props => [error];
}

class FirebaseFailure extends Failure {
  final String error;

  FirebaseFailure(this.error);

  @override
  List<Object> get props => [error];
}

class ConnectionFailure extends Failure {
  final String error;

  ConnectionFailure(this.error);

  @override
  List<Object> get props => [error];
}
