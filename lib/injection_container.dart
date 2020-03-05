import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/repositories/local_settings_repository_impl.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton(await SharedPreferences.getInstance());
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
}
