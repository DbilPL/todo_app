import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/introduction/presentation/bloc/bloc.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

import 'features/authetification/presenation/pages/auth_page.dart';
import 'features/introduction/presentation/bloc/bloc.dart';
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
  static const flareFilesData = [
    {'name': 'Intro1', 'text': 'Simple to use.'},
    {'name': 'Intro2', 'text': 'Cloud saving'},
    {'name': 'Intro3', 'text': 'Your data is save'},
  ];

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
        if (state is CacheFailureState) {
          return MaterialApp(
            theme: ThemeData(
              backgroundColor: state.settingsModel.backgroundColor,
              primaryColor: state.settingsModel.primaryColor,
              accentColor: state.settingsModel.accentColor,
              fontFamily: state.settingsModel.fontFamily,
            ),
            home: SafeArea(
              child: Scaffold(
                body: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('Something went wrong!'),
                      RaisedButton(
                        onPressed: () {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(LoadSettings());
                        },
                        child: Text('Try again'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: state.settingsModel.primaryColor,
              accentColor: state.settingsModel.accentColor,
              backgroundColor: state.settingsModel.backgroundColor,
              fontFamily: state.settingsModel.fontFamily,
            ),
            routes: {
              '/auth': (context) => AuthPage(),
              // '/todo': (context) => TodoPage(),
            },
            home: Scaffold(
              body: SafeArea(
                child: BlocListener<SettingsBloc, SettingsState>(
                  listener: (BuildContext context, state) {
                    if (state is FirstRunState) {
                      BlocProvider.of<IntroductionBloc>(context)
                          .add(Introduce());
                    }
                    if (state is AlreadyRunned) {
                      Navigator.pushReplacementNamed(context, '/auth');
                    }
                  },
                  child: BlocListener<IntroductionBloc, IntroductionState>(
                    listener:
                        (BuildContext context, IntroductionState state) async {
                      if (state is LoadedState) {
                        print('print!');
                      }

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
                      builder: (BuildContext context, IntroductionState state) {
                        if (state is CacheFailureState) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  'Something went wrong!',
                                  style: TextStyle(fontSize: 35),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    BlocProvider.of<IntroductionBloc>(context)
                                        .add(AppStart());
                                  },
                                  color: Theme.of(context).primaryColor,
                                  child: Text('Reload'),
                                ),
                              ],
                            ),
                          );
                        }
                        if (state is AppStarted)
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 36.0, top: 30.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.7,
                                child: FlareActor(
                                  'assets/animations/Logo.flr',
                                  animation: 'animation',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        if (state is EnterOrIntroduceState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is IntroduceApp) {
                          return DefaultTabController(
                            length: flareFilesData.length,
                            initialIndex: 0,
                            child: Builder(
                              builder: (BuildContext context) => SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TabPageSelector(),
                                    Expanded(
                                      child: TabBarView(
                                        children: flareFilesData.map(
                                          (val) {
                                            return Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    val['text'],
                                                    style: TextStyle(
                                                      fontSize: 35,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: FlareActor(
                                                      'assets/animations/${val['name']}.flr',
                                                      animation: 'animate',
                                                    ),
                                                  ),
                                                  val['name'] == 'Intro3'
                                                      ? RaisedButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushReplacementNamed(
                                                                    context,
                                                                    '/auth');
                                                          },
                                                          child: Text(
                                                              'Start work'),
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        )
                                                      : Text(''),
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else
                          return Container();
                      },
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
