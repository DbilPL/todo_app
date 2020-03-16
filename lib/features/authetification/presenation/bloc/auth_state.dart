import 'package:equatable/equatable.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class FirebaseFailureState extends AuthState {
  final String failure;

  FirebaseFailureState(this.failure);

  @override
  List<Object> get props => [failure];
}

class SignedIn extends AuthState {
  final UserModel user;

  SignedIn(this.user);

  @override
  List<Object> get props => [];
}
