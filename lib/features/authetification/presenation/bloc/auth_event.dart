import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class UserEntered extends AuthEvent {
  @override
  List<Object> get props => [];
}

class EnterWithoutAccountEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class CreateAccountToNoAccountUser extends AuthEvent {
  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String email, password, repeatPassword;

  RegisterEvent(this.email, this.password, this.repeatPassword);

  @override
  List<Object> get props => [email, password, repeatPassword];
}

class SignInEvent extends AuthEvent {
  final String email, password;

  SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
