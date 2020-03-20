import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';
import 'package:todoapp/features/introduction/presentation/pages/introduction_page.dart';
import 'package:todoapp/features/introduction/presentation/pages/on_failure-page.dart';
import 'package:todoapp/features/introduction/presentation/pages/on_run_page.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';
import 'package:todoapp/features/settings/presentation/pages/settings_page.dart';

import 'features/authetification/presenation/pages/auth_page.dart';
import 'features/introduction/presentation/bloc/bloc.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inits all instances from one point
  await di.init();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
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
        if (state is CacheFailureState) {
          return MaterialApp(
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
        } else
          return MaterialApp(
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
            home: Scaffold(
              body: SafeArea(
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is FirebaseFailureState) {
                      Navigator.pushReplacementNamed(context, '/auth');
                    }
                    if (state is FailureState) {
                      Navigator.pushReplacementNamed(context, '/auth');
                    }
                    if (state is Entered) {
                      Navigator.pushReplacementNamed(context, '/todo');
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
                    },
                    child: BlocListener<IntroductionBloc, IntroductionState>(
                      listener: (BuildContext context,
                          IntroductionState state) async {
                        if (state is EnterOrIntroduceState) {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(LoadSettings());
                        }

                        if (state is AppStarted) {
                          await Future.delayed(Duration(seconds: 4), () {
                            BlocProvider.of<IntroductionBloc>(context)
                                .add(EnterOrIntroduce());
                          });
                        }
                      },
                      child: BlocBuilder<IntroductionBloc, IntroductionState>(
                        builder:
                            (BuildContext context, IntroductionState state) {
                          if (state is CacheFailureState) {
                            return OnFailurePage();
                          }
                          if (state is AppStarted) return OnRunPage();
                          if (state is EnterOrIntroduceState) {
                            return Container(
                              color: Theme.of(context).backgroundColor,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              ),
                            );
                          }
                          if (state is IntroduceApp) {
                            return IntroducitonPage();
                          } else
                            return Container();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
      },
    );
  }
}
