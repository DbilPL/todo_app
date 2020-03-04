import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/repositories/local_settings_repository_impl.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(FlutterSecureStorage());
  sl.registerFactory(() => SettingsLocalDatasourceImpl(sl()));
  sl.registerFactory(() => LocalSettingsRepositoryImpl(sl()));
  sl.registerFactory(
      () => GetCurrentSettings(sl<LocalSettingsRepositoryImpl>()));
  sl.registerFactory(() => SetSettings(sl<LocalSettingsRepositoryImpl>()));

  sl.registerSingleton(
      SettingsBloc(sl<GetCurrentSettings>(), sl<SetSettings>()));
}
