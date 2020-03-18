import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/usecases/register.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_auto.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_out.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOut signOut;
  final SignIn signIn;
  final Register register;
  final SignInAuto signInAuto;

  AuthBloc(this.signOut, this.signIn, this.register, this.signInAuto);

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield LoadingState();

    if (event is UserEntered) {
      try {
        final signInAutoOrFailure = await signInAuto(NoParams());

        yield signInAutoOrFailure.fold((failure) {
          print(failure.error);
          return FailureState(failure.error);
        }, (user) {
          return Entered(user);
        });
      } catch (e) {
        print(e.toString());
        yield FailureState('Something went wrong!');
      }
    }

    if (event is RegisterEvent) {
      RegExp emailRegExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      final password = event.password.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      final email = event.email.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      final repeatPassword =
          event.repeatPassword.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      if (emailRegExp.hasMatch(email)) {
        if (password.length > 6) {
          if (password == repeatPassword) {
            final signInOrFailure =
                await register(RegisterParams(email, password));

            yield signInOrFailure.fold((failure) {
              return FirebaseFailureState(failure.error);
            }, (user) {
              print('registered');
              return Entered(user);
            });
          } else
            yield InputFailure('Password does not match!');
        } else
          yield InputFailure('Password shall contain at least 6 chars!');
      } else
        yield InputFailure('Not valid email entered!');
    }

    if (event is SignInEvent) {
      RegExp emailRegExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      final password = event.password.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      final email = event.email.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      if (emailRegExp.hasMatch(email)) {
        if (password.length > 6) {
          final signInOrFailure = await signIn(SignInParams(email, password));

          yield signInOrFailure.fold((failure) {
            return FirebaseFailureState(failure.error);
          }, (user) {
            print('registered');
            return Entered(user);
          });
        } else
          yield InputFailure('Password shall contain at least 6 chars!');
      } else
        yield InputFailure('Not valid email entered!');
    }

    if (event is SignOutEvent) {
      try {
        final out = await signOut(NoParams());

        yield out.fold((failure) {
          return FirebaseFailureState(failure.error);
        }, (_) {
          print('signed out');
          return SignedOut();
        });
      } catch (e) {
        yield FirebaseFailureState('Something went wrong!');
      }
    }

    if (event is EnterWithoutAccountEvent) {
      print('registered');
      yield Entered(NoAccountUser());
    }

    if (event is CreateAccountToNoAccountUser) {
      yield CreateAccountToNoAccountUserState();
    }
  }
}
