import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_anon.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInAnon signInAnon;

  AuthBloc(this.signInAnon);

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInAnonEvent) {
      try {
        final user = await signInAnon(NoParams());

        yield user.fold((failure) {
          return FirebaseFailureState(failure.error);
        }, (user) {
          print(user.uid);
          return SignedIn(UserModel(uid: user.uid));
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
