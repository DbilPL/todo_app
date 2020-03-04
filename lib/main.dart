import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';

import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  // inits all instances from one point
  await di.init();

  runApp(BlocProvider<SettingsBloc>(
    child: MyApp(),
    create: (BuildContext context) {
      return sl<SettingsBloc>()..add(AppStarted());
    },
  ));
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

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlocListener<SettingsBloc, SettingsState>(
            listener: (BuildContext context, SettingsState state) {},
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (BuildContext context, SettingsState state) {
                if (state is FailureSettingsState) {
                  if (state is CacheFailureState) {
                    return Text(state.error);
                  } else
                    return Text('0_0');
                } else if (state is IntroductionAppState) {
                  return Text('yay!');
                } else
                  return Text('._. ${state.runtimeType}');
              },
            ),
          ),
        ),
      ),
    );
  }
}
