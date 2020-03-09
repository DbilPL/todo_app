import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

import 'features/introduction/presentation/bloc/bloc.dart';
import 'features/introduction/presentation/pages/how_app_works_page.dart';
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
            create: (BuildContext context) => sl<SettingsBloc>()
            // ..add(AppStarted()),
            ),
        BlocProvider<IntroductionBloc>(
          create: (BuildContext context) =>
              sl<IntroductionBloc>()..add(IntroduceApp()),
        ),
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0Xfff8f8f8),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: state.settingsModel.primaryColor,
            accentColor: state.settingsModel.accentColor,
            backgroundColor: state.settingsModel.backgroundColor,
          ),
          home: Scaffold(
            body: BlocListener<IntroductionBloc, IntroductionState>(
              listener: (BuildContext context, IntroductionState state) async {
                if (state is IntroduceAppState) {
                  await Future.delayed(Duration(seconds: 3));

                  BlocProvider.of<IntroductionBloc>(context)
                      .add(EnterOrIntroduce());
                }
              },
              child: BlocBuilder<IntroductionBloc, IntroductionState>(
                builder: (BuildContext context, IntroductionState state) {
                  if (state is IntroduceAppState)
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 36.0, top: 30.0),
                        child: Container(
                          width: 350,
                          height: 250,
                          child: FlareActor(
                            'assets/animations/Logo.flr',
                            animation: 'animation',
                            color: Colors.black,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  if (state is HowAppWorksState) {
                    return HowAppWorksPage();
                  } else
                    return Container();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
