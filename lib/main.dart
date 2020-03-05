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

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (BuildContext context, SettingsState state) {
        return MaterialApp(
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
                    return Stack(
                      children: <Widget>[],
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
    );
  }
}
