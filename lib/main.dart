import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

import 'injection_container.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inits all instances from one point
  await di.init();

  runApp(
    BlocProvider<SettingsBloc>(
      child: MyApp(),
      create: (BuildContext context) {
        return sl<SettingsBloc>()..add(AppStarted());
      },
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
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0Xfff8f8f8),
        systemNavigationBarIconBrightness: Brightness.dark));

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is LoadedState) {
          Navigator.pushReplacementNamed(context, '/todo_page');
        }
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
          return MaterialApp(
            routes: {
              // '/todo_page': (context) => TODOPage(),
            },
            theme: ThemeData(
                primaryColor: state.settingsModel.primaryColor,
                backgroundColor: state.settingsModel.backgroundColor,
                accentColor: state.settingsModel.accentColor),
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                body: Builder(
                  builder: (BuildContext context) {
                    print(state.runtimeType.toString());

                    if (state is InitialSettingsState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is IntroductionAppState) {
                      return BlocProvider<SettingsBloc>(
                        create: (context) => sl<SettingsBloc>(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Welcome to ',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 30,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'TODO ',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'app!',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  print('yay');
                                  sl<SettingsBloc>().add(HowAppWorks());
                                },
                                child: Text(
                                  'Start',
                                  style: TextStyle(
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is HowAppWorksState) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('introduce'),
                            FlatButton(
                              onPressed: () {
//                                BlocProvider.of<SettingsBloc>(context)
//                                    .add(IntroduceEnded());
                              },
                              child: Text(
                                'Start',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      );
                    } else if (state is LoadedState) {
                      return Center(
                        child: Text('loaded'),
                      );
                    } else
                      return Center(
                        child: Text(state.runtimeType.toString()),
                      );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
