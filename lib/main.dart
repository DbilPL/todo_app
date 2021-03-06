import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todoapp/core/methods.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';
import 'package:todoapp/features/introduction/presentation/pages/introduction_page.dart';
import 'package:todoapp/features/introduction/presentation/pages/on_failure-page.dart';
import 'package:todoapp/features/introduction/presentation/pages/on_run_page.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';
import 'package:todoapp/features/settings/presentation/pages/settings_page.dart';
import 'package:todoapp/features/todo/presentation/bloc/bloc.dart';

import 'core/bloc_delegate.dart';
import 'features/authetification/data/model/user_model.dart';
import 'features/authetification/presenation/pages/auth_page.dart';
import 'features/introduction/presentation/bloc/bloc.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inits all instances from one point
  await di.init();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) =>
              sl<TodoBloc>()..add(const LoadLocalTodoInitial([])),
        ),
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) => sl<SettingsBloc>(),
        ),
        BlocProvider<IntroductionBloc>(
          create: (BuildContext context) =>
              sl<IntroductionBloc>()..add(AppStart()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        if (state is LoadingSettingsState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TODO App',
            theme: ThemeData(
              backgroundColor: state.settingsModel.backgroundColor,
              primaryColor: state.settingsModel.primaryColor,
              fontFamily: state.settingsModel.fontFamily,
              canvasColor: state.settingsModel.primaryColor,
              iconTheme: IconThemeData(
                color: state.settingsModel.backgroundColor,
              ),
              textTheme: TextTheme(
                caption: TextStyle(
                  color: state.settingsModel.fontColor,
                ),
              ),
            ),
            home: SafeArea(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            routes: {
              '/auth': (context) => AuthPage(),
              '/todo': (context) => TodoPage(),
              '/settings': (context) => SettingsPage(),
            },
          );
        }
        if (state is CacheFailureState) {
          return MaterialApp(
            title: 'TODO App',
            theme: ThemeData(
              backgroundColor: state.settingsModel.backgroundColor,
              primaryColor: state.settingsModel.primaryColor,
              fontFamily: state.settingsModel.fontFamily,
              canvasColor: state.settingsModel.primaryColor,
              iconTheme: IconThemeData(
                color: state.settingsModel.backgroundColor,
              ),
              textTheme: TextTheme(
                caption: TextStyle(
                  color: state.settingsModel.fontColor,
                ),
              ),
            ),
            home: SafeArea(
              child: Scaffold(
                body: OnFailurePage(),
              ),
            ),
          );
        } else {
          return MaterialApp(
            title: 'TODO App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: state.settingsModel.primaryColor,
              backgroundColor: state.settingsModel.backgroundColor,
              fontFamily: state.settingsModel.fontFamily,
              iconTheme: IconThemeData(
                color: state.settingsModel.backgroundColor,
              ),
              textTheme: TextTheme(
                caption: TextStyle(
                  color: state.settingsModel.fontColor,
                ),
              ),
            ),
            routes: {
              '/auth': (context) => AuthPage(),
              '/todo': (context) => TodoPage(),
              '/settings': (context) => SettingsPage(),
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: Scaffold(
              body: SafeArea(
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is FirebaseFailureState ||
                        state is FailureState) {
                      Navigator.pushReplacementNamed(context, '/auth');
                    }
                    if (state is Entered) {
                      final user = state.user as UsualUserModel;

                      final isUserRegistered = isRegistered(context);
                      if (isUserRegistered) {
                        BlocProvider.of<SettingsBloc>(context).add(
                          LoadSettingsRemote(
                            uid: user.uid,
                            prevSettings: BlocProvider.of<SettingsBloc>(context)
                                .state
                                .settingsModel,
                          ),
                        );

                        BlocProvider.of<TodoBloc>(context).add(
                          LoadRemoteTodoInitial(
                            BlocProvider.of<TodoBloc>(context).state.list,
                            user.uid,
                          ),
                        );

                        Navigator.of(context).pushReplacementNamed('/todo');
                      } else {
                        Navigator.of(context).pushReplacementNamed('/todo');
                      }
                    }
                  },
                  child: BlocListener<SettingsBloc, SettingsState>(
                    listener: (BuildContext context, state) {
                      if (state is FirstRunState) {
                        BlocProvider.of<IntroductionBloc>(context)
                            .add(Introduce());
                      }
                      if (state is AlreadyRunned) {
                        BlocProvider.of<AuthBloc>(context).add(UserEntered());
                      }
                      if (state is ConnectionFailureState) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You have no connection to internet!',
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor),
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );

                        Navigator.of(context).pushReplacementNamed('/todo');
                      }
                    },
                    child: BlocListener<IntroductionBloc, IntroductionState>(
                      listener: (BuildContext context,
                          IntroductionState state) async {
                        if (state is EnterOrIntroduceState) {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(LoadSettingsLocalInitial());
                        }

                        if (state is AppStarted) {
                          await Future.delayed(const Duration(seconds: 3), () {
                            BlocProvider.of<IntroductionBloc>(context)
                                .add(EnterOrIntroduce());
                          });
                        }
                      },
                      child: BlocBuilder<IntroductionBloc, IntroductionState>(
                        builder:
                            (BuildContext context, IntroductionState state) {
                          if (state is AppStarted) return OnRunPage();
                          if (state is IntroduceApp) return IntroducitonPage();
                          if (state is EnterOrIntroduceState) {
                            return Container(
                              color: Theme.of(context).backgroundColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Waiting for data...',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (state is CacheFailureState) {
                            return OnFailurePage();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
