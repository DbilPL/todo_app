import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/authetification/data/datasource/firebase_auth_datasource.dart';
import 'package:todoapp/features/authetification/data/repositories/firebase_auth_repository_impl.dart';
import 'package:todoapp/features/authetification/domain/usecases/register.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_in_auto.dart';
import 'package:todoapp/features/authetification/domain/usecases/sign_out.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';
import 'package:todoapp/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:todoapp/features/notifications/data/repositories/local_notifications_repository_impl.dart';
import 'package:todoapp/features/notifications/domain/usecases/cancel_notification_local.dart';
import 'package:todoapp/features/notifications/domain/usecases/set_notification_local.dart';
import 'package:todoapp/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:todoapp/features/settings/data/datasource/settings_remote_datasource.dart';
import 'package:todoapp/features/settings/data/repositories/local_settings_repository_impl.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_remote.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings_local.dart';
import 'package:todoapp/features/settings/domain/usecases/set_settings_remote.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';
import 'package:todoapp/features/todo/data/datasource/todo_remote_datasource.dart';
import 'package:todoapp/features/todo/data/repository/local_todo_repository_impl.dart';
import 'package:todoapp/features/todo/data/repository/todo_remote_repository_impl.dart';
import 'package:todoapp/features/todo/domain/usecases/get_local_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/get_remote_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/set_local_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/update_remote_todo.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

import 'features/authetification/domain/usecases/sign_in.dart';
import 'features/notifications/domain/usecases/cancel_all_notifications_local.dart';
import 'features/settings/data/repositories/remote_settings_repository_impl.dart';
import 'features/todo/data/datasource/todo_local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// some help for app
  sl.registerSingleton(await SharedPreferences.getInstance());
  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerSingleton(Firestore.instance);
  sl.registerSingleton(FlutterLocalNotificationsPlugin());
  // settings
  sl.registerSingleton(SettingsLocalDatasourceImpl(sl<SharedPreferences>()));
  sl.registerSingleton(
      LocalSettingsRepositoryImpl(sl<SettingsLocalDatasourceImpl>()));
  sl.registerSingleton(
      GetCurrentSettingsLocal(sl<LocalSettingsRepositoryImpl>()));
  sl.registerSingleton(SetSettingsLocal(sl<LocalSettingsRepositoryImpl>()));
  sl.registerSingleton(SettingsRemoteDatasourceImpl(sl<Firestore>()));
  sl.registerSingleton(
      RemoteSettingsRepositoryImpl(sl<SettingsRemoteDatasourceImpl>()));
  sl.registerSingleton(
      GetCurrentSettingsRemote(sl<RemoteSettingsRepositoryImpl>()));
  sl.registerSingleton(SetSettingsRemote(sl<RemoteSettingsRepositoryImpl>()));
  sl.registerSingleton(
    SettingsBloc(
      sl<GetCurrentSettingsLocal>(),
      sl<SetSettingsLocal>(),
      sl<GetCurrentSettingsRemote>(),
      sl<SetSettingsRemote>(),
    ),
  );

  /// notifications

  sl.registerSingleton(
      LocalNotificationsDatasourceImpl(sl<FlutterLocalNotificationsPlugin>()));
  sl.registerSingleton(
      LocalNotificationsRepositoryImpl(sl<LocalNotificationsDatasourceImpl>()));
  sl.registerSingleton(
      CancelNotificationLocal(sl<LocalNotificationsRepositoryImpl>()));
  sl.registerSingleton(
      SetNotificationLocal(sl<LocalNotificationsRepositoryImpl>()));
  sl.registerSingleton(
      CancelAllNotificationsLocal(sl<LocalNotificationsRepositoryImpl>()));

  // introduction
  sl.registerSingleton(
    IntroductionBloc(),
  );

  // T0D0
  sl.registerSingleton(TodoRemoteDatasourceImpl(sl<Firestore>()));
  sl.registerSingleton(TODOLocalDatasourceImpl(sl<SharedPreferences>()));
  sl.registerSingleton(
      TodoRemoteRepositoryImpl(sl<TodoRemoteDatasourceImpl>()));
  sl.registerSingleton(LocalTODORepositoryImpl(sl<TODOLocalDatasourceImpl>()));
  sl.registerSingleton(GetRemoteTODO(sl<TodoRemoteRepositoryImpl>()));
  sl.registerSingleton(UpdateRemoteTODO(sl<TodoRemoteRepositoryImpl>()));
  sl.registerSingleton(GetLocalTodo(sl<LocalTODORepositoryImpl>()));
  sl.registerSingleton(SetLocalTODO(sl<LocalTODORepositoryImpl>()));
  sl.registerSingleton(
    TodoBloc(
        sl<GetLocalTodo>(),
        sl<SetLocalTODO>(),
        sl<CancelNotificationLocal>(),
        sl<SetNotificationLocal>(),
        sl<CancelAllNotificationsLocal>()),
  );

  /// auth
  sl.registerSingleton(
      FirebaseAuthDatasourceImpl(sl<FirebaseAuth>(), sl<SharedPreferences>()));
  sl.registerSingleton(
      FirebaseAuthRepositoryImpl(sl<FirebaseAuthDatasourceImpl>()));
  sl.registerSingleton(SignOut(sl<FirebaseAuthRepositoryImpl>()));
  sl.registerSingleton(SignIn(sl<FirebaseAuthRepositoryImpl>()));
  sl.registerSingleton(Register(sl<FirebaseAuthRepositoryImpl>()));
  sl.registerSingleton(SignInAuto(sl<FirebaseAuthRepositoryImpl>()));
  sl.registerSingleton(AuthBloc(
    sl<SignOut>(),
    sl<SignIn>(),
    sl<Register>(),
    sl<SignInAuto>(),
  ));
}
