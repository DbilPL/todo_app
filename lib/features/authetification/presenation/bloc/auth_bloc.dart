import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/usecases/register.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_auto.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_out.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOut signOut;
  final SignIn signIn;
  final Register register;
  final SignInAuto signInAuto;

  AuthBloc(
    this.signOut,
    this.signIn,
    this.register,
    this.signInAuto,
  );

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield LoadingState();

    final RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    final RegExp spaces = RegExp(r"\s+\b|\b\s");

    if (event is UserEntered) {
      try {
        final signInAutoOrFailure = await signInAuto(NoParams());

        yield signInAutoOrFailure.fold((failure) {
          if (failure is ConnectionFailure) {
            print('sign in auto with no internet');
            return Entered(NoAccountUser());
          } else
            return FailureState(failure.error);
        }, (user) {
          print('sign in auto');
          return Entered(user, typeOf: 'auto');
        });
      } catch (e) {
        print(e.toString());
        yield FailureState('Something went wrong!');
      }
    }

    if (event is RegisterEvent) {
      final password = event.password.replaceAll(spaces, "");
      final email = event.email.replaceAll(spaces, "");
      final repeatPassword = event.repeatPassword.replaceAll(spaces, "");
      if (emailRegExp.hasMatch(email)) {
        if (password.length > 6) {
          if (password == repeatPassword) {
            final signInOrFailure =
                await register(RegisterParams(email, password));

            yield signInOrFailure.fold((failure) {
              return FailureState(failure.error);
            }, (user) {
              print('registered');
              return Entered(user, typeOf: 'register');
            });
          } else
            yield InputFailure('Password does not match!');
        } else
          yield InputFailure('Password shall contain at least 6 chars!');
      } else
        yield InputFailure('Not valid email entered!');
    }

    if (event is SignInEvent) {
      final password = event.password.replaceAll(spaces, "");
      final email = event.email.replaceAll(spaces, "");
      if (emailRegExp.hasMatch(email)) {
        if (password.length > 6) {
          final signInOrFailure = await signIn(SignInParams(email, password));

          yield signInOrFailure.fold((failure) {
            return FirebaseFailureState(failure.error);
          }, (user) {
            print('sign in');
            return Entered(user, typeOf: 'sign in');
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
          return Entered(event.user,
              error: 'Failed to sign out! Check your internet connection!');
        }, (_) {
          print('signed out');
          return SignedOut();
        });
      } catch (e) {
        yield Entered(event.user, error: 'Something went wrong!');
      }
    }

    if (event is EnterWithoutAccountEvent) {
      print('registered');
      if (!(await DataConnectionChecker().hasConnection) || event.areYouSure) {
        yield Entered(NoAccountUser());
      } else
        yield AreYouSureForEnteringWithoutAccount();
    }

    if (event is CreateAccountToNoAccountUser) {
      yield CreateAccountToNoAccountUserState();
    }
  }
}
