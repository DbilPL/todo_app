import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/util/domain/usecases/has_connection.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/domain/usecases/register.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_auto.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_out.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../settings/domain/usecases/get_current_settings_local.dart';
import '../../data/model/user_model.dart';
import '../../domain/usecases/sign_in.dart';
import './bloc.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOut _signOut;
  final SignIn _signIn;
  final Register _register;
  final SignInAuto _signInAuto;
  final HasConnection _hasConnection;

  AuthBloc(
    this._signOut,
    this._signIn,
    this._register,
    this._signInAuto,
    this._hasConnection,
  );

  final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final RegExp spaces = RegExp(r"\s+\b|\b\s");

  @override
  AuthState get initialState => InitialAuthState();

  Stream<AuthState> _authenticate(
      String email,
      String password,
      String repeatPassword,
      UseCase<UsualUserModel, AuthParams> usecase,
      AuthType type) async* {
    if (emailRegExp.hasMatch(email)) {
      if (password.length > 6) {
        if (password == repeatPassword) {
          final authOrFailure = await usecase(AuthParams(email, password));

          yield authOrFailure.fold((failure) {
            return FailureState(failure.error);
          }, (user) {
            return Entered(user, typeOf: type);
          });
        } else {
          yield const InputFailure('Password does not match!');
        }
      } else {
        yield const InputFailure('Password shall contain at least 6 chars!');
      }
    } else {
      yield const InputFailure('Not valid email entered!');
    }
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield LoadingState();

    if (event is UserEntered) {
      try {
        final signInAutoOrFailure = await _signInAuto(NoParams());

        yield signInAutoOrFailure.fold((failure) {
          if (failure is ConnectionFailure) {
            return const Entered(NoAccountUser());
          } else {
            return FailureState(failure.error);
          }
        }, (user) {
          return Entered(user, typeOf: AuthType.auto);
        });
      } catch (e) {
        yield const FailureState('Something went wrong!');
      }
    }

    if (event is RegisterEvent) {
      final password = event.password.replaceAll(spaces, "");
      final email = event.email.replaceAll(spaces, "");
      final repeatPassword = event.repeatPassword.replaceAll(spaces, "");

      yield* _authenticate(
          email, password, repeatPassword, _register, AuthType.register);
    }

    if (event is SignInEvent) {
      final password = event.password.replaceAll(spaces, "");
      final email = event.email.replaceAll(spaces, "");

      yield* _authenticate(email, password, password, _signIn, AuthType.signIn);
    }

    if (event is SignOutEvent) {
      try {
        final out = await _signOut(NoParams());

        yield out.fold((failure) {
          return Entered(event.user,
              error: 'Failed to sign out! Check your internet connection!');
        }, (_) {
          return SignedOut();
        });
      } catch (e) {
        yield Entered(event.user, error: 'Something went wrong!');
      }
    }

    if (event is EnterWithoutAccountEvent) {
      final hasConnectionOrFailure = await _hasConnection(NoParams());

      yield hasConnectionOrFailure.fold(
        (failure) => FailureState(failure.error),
        (isConnected) {
          if (!isConnected || event.areYouSure) {
            return const Entered(NoAccountUser());
          } else {
            return AreYouSureForEnteringWithoutAccount();
          }
        },
      );
    }

    if (event is CreateAccountToNoAccountUser) {
      yield CreateAccountToNoAccountUserState();
    }
  }
}
