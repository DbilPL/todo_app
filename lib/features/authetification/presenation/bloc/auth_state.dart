import 'package:equatable/equatable.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class FailureState extends AuthState {
  final String failure;

  FailureState(this.failure);

  @override
  List<Object> get props => [failure];
}

class FirebaseFailureState extends AuthState {
  final String failure;

  FirebaseFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}

class AreYouSureForEnteringWithoutAccount extends AuthState {
  @override
  List<Object> get props => [];
}

class InputFailure extends AuthState {
  final String failure;

  InputFailure(this.failure);

  @override
  List<Object> get props => [];
}

class Entered extends AuthState {
  final UserModel user;

  final String error;

  Entered(this.user, {this.error});

  @override
  List<Object> get props => [user];
}

class SignedOut extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class ConnectionFailureTODOState extends AuthState {
  @override
  List<Object> get props => [];
}

class FirebaseFailureTODOState extends AuthState {
  @override
  List<Object> get props => [];
}

class CreateAccountToNoAccountUserState extends AuthState {
  @override
  List<Object> get props => [];
}
