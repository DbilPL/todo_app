import 'package:equatable/equatable.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class UserEntered extends AuthEvent {
  @override
  List<Object> get props => [];
}

class EnterWithoutAccountEvent extends AuthEvent {
  final bool areYouSure;

  const EnterWithoutAccountEvent({this.areYouSure});

  @override
  List<Object> get props => [areYouSure];
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
  final UserModel user;

  SignOutEvent(this.user);

  @override
  List<Object> get props => [user];
}
