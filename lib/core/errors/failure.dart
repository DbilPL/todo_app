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
