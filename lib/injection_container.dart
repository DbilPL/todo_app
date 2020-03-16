import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/authetification/data/datasource/firebase_auth_datasource.dart';
import 'package:todoapp/features/authetification/data/repositories/firebase_auth_repository_impl.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_anon.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/repositories/local_settings_repository_impl.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// some help for app
  sl.registerSingleton(await SharedPreferences.getInstance());
  sl.registerSingleton(FirebaseAuth.instance);
  // settings
  sl.registerSingleton(SettingsLocalDatasourceImpl(sl<SharedPreferences>()));
  sl.registerSingleton(
      LocalSettingsRepositoryImpl(sl<SettingsLocalDatasourceImpl>()));
  sl.registerSingleton(GetCurrentSettings(sl<LocalSettingsRepositoryImpl>()));
  sl.registerSingleton(SetSettings(sl<LocalSettingsRepositoryImpl>()));
  sl.registerSingleton(
    SettingsBloc(
      sl<GetCurrentSettings>(),
      sl<SetSettings>(),
    ),
  );
  // introduction
  sl.registerSingleton(
    IntroductionBloc(),
  );

  /// auth
  sl.registerSingleton(FirebaseAuthDatasourceImpl(sl<FirebaseAuth>()));
  sl.registerSingleton(
      FirebaseAuthRepositoryImpl(sl<FirebaseAuthDatasourceImpl>()));
  sl.registerSingleton(SignInAnon(sl<FirebaseAuthRepositoryImpl>()));
  sl.registerSingleton(AuthBloc(sl<SignInAnon>()));
}
