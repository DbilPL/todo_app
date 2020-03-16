import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInAnonEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
