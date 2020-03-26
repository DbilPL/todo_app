import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';
import 'package:todoapp/features/authetification/presenation/bloc/bloc.dart';
import 'package:todoapp/features/settings/data/models/settings_model.dart';
import 'package:todoapp/features/settings/presentation/bloc/bloc.dart';
import 'package:todoapp/features/settings/presentation/widgets/color_circle.dart';
import 'package:todoapp/features/settings/presentation/widgets/font_viewer.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            'Settings',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is Entered) {
                  if (state.user is UsualUserModel) {
                    return ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(''),
                          accountEmail: Text(
                            state.user.props[1],
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'To TODO',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.caption.color,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/todo');
                          },
                        ),
                      ],
                    );
                  } else
                    return ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(''),
                          accountEmail: Text(
                            'Anoniymous',
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'To TODO',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.caption.color,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/todo');
                          },
                        ),
                      ],
                    );
                } else
                  return Text('How did you get here?!');
              },
            ),
          ),
        ),
        body: BlocListener<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state is CacheFailureState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Something went wrong!',
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, _state) {
              if (_state is Entered) {
                if (_state.user is UsualUserModel) {
                  return BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Background color',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ColorCircle(
                                color: Colors.white,
                                onPressed: () {
                                  SettingsModel newSettings = SettingsModel(
                                    fontColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    fontFamily: state.settingsModel.fontFamily,
                                    primaryColor:
                                        state.settingsModel.primaryColor,
                                  );

                                  BlocProvider.of<SettingsBloc>(context).add(
                                      SetSettingsRemoteEvent(
                                          newSettings,
                                          state.settingsModel,
                                          _state.user.props[0]));
                                },
                              ),
                              ColorCircle(
                                color: Colors.black,
                                onPressed: () {
                                  SettingsModel newSettings = SettingsModel(
                                    fontColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    fontFamily: state.settingsModel.fontFamily,
                                    primaryColor:
                                        state.settingsModel.primaryColor,
                                  );

                                  BlocProvider.of<SettingsBloc>(context).add(
                                    SetSettingsRemoteEvent(
                                      newSettings,
                                      state.settingsModel,
                                      _state.user.props[0],
                                    ),
                                  );
                                },
                              ),
                            ]
                                .map(
                                  (widget) => Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: widget,
                                  ),
                                )
                                .toList(),
                          ),
                          ListTile(
                            title: Text(
                              'Primary color',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Colors.black,
                                Colors.white,
                                Colors.grey,
                                Colors.red,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.purple,
                                Colors.pink,
                              ].map(
                                (val) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ColorCircle(
                                      color: val,
                                      onPressed: () {
                                        BlocProvider.of<SettingsBloc>(context)
                                            .add(
                                          SetSettingsRemoteEvent(
                                            SettingsModel(
                                              primaryColor: val,
                                              backgroundColor: state
                                                  .settingsModel
                                                  .backgroundColor,
                                              fontColor:
                                                  state.settingsModel.fontColor,
                                              fontFamily: state
                                                  .settingsModel.fontFamily,
                                            ),
                                            state.settingsModel,
                                            _state.user.props[0],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Font family',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                'Raleway',
                                'Abel',
                                'BalooChettan2',
                                'Handlee',
                                'Montserrat',
                                'NanumPenScript',
                                'OpenSansCondensed',
                                'Sen',
                                'TitanOne',
                              ].map<Widget>(
                                (val) {
                                  return FontViewer(
                                    font: val,
                                    onTap: () {
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(
                                        SetSettingsRemoteEvent(
                                          SettingsModel(
                                            backgroundColor: state
                                                .settingsModel.backgroundColor,
                                            fontColor:
                                                state.settingsModel.fontColor,
                                            primaryColor: state
                                                .settingsModel.primaryColor,
                                            fontFamily: val,
                                          ),
                                          state.settingsModel,
                                          _state.user.props[0],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else
                  return BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'Background color',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ColorCircle(
                                color: Colors.white,
                                onPressed: () {
                                  SettingsModel newSettings = SettingsModel(
                                    fontColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    fontFamily: state.settingsModel.fontFamily,
                                    primaryColor:
                                        state.settingsModel.primaryColor,
                                  );

                                  BlocProvider.of<SettingsBloc>(context).add(
                                    SetSettingsLocalEvent(
                                      newSettings,
                                      state.settingsModel,
                                    ),
                                  );
                                },
                              ),
                              ColorCircle(
                                color: Colors.black,
                                onPressed: () {
                                  SettingsModel newSettings = SettingsModel(
                                    fontColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    fontFamily: state.settingsModel.fontFamily,
                                    primaryColor:
                                        state.settingsModel.primaryColor,
                                  );

                                  BlocProvider.of<SettingsBloc>(context).add(
                                    SetSettingsLocalEvent(
                                      newSettings,
                                      state.settingsModel,
                                    ),
                                  );
                                },
                              ),
                            ]
                                .map(
                                  (widget) => Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: widget,
                                  ),
                                )
                                .toList(),
                          ),
                          ListTile(
                            title: Text(
                              'Primary color',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Colors.black,
                                Colors.white,
                                Colors.grey,
                                Colors.red,
                                Colors.orange,
                                Colors.yellow,
                                Colors.green,
                                Colors.blue,
                                Colors.purple,
                                Colors.pink,
                              ].map(
                                (val) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ColorCircle(
                                      color: val,
                                      onPressed: () {
                                        BlocProvider.of<SettingsBloc>(context)
                                            .add(
                                          SetSettingsLocalEvent(
                                            SettingsModel(
                                              primaryColor: val,
                                              backgroundColor: state
                                                  .settingsModel
                                                  .backgroundColor,
                                              fontColor:
                                                  state.settingsModel.fontColor,
                                              fontFamily: state
                                                  .settingsModel.fontFamily,
                                            ),
                                            state.settingsModel,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Font family',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                'Raleway',
                                'Abel',
                                'BalooChettan2',
                                'Handlee',
                                'Montserrat',
                                'NanumPenScript',
                                'OpenSansCondensed',
                                'Sen',
                                'TitanOne',
                              ].map<Widget>(
                                (val) {
                                  return FontViewer(
                                    font: val,
                                    onTap: () {
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(
                                        SetSettingsLocalEvent(
                                          SettingsModel(
                                            backgroundColor: state
                                                .settingsModel.backgroundColor,
                                            fontColor:
                                                state.settingsModel.fontColor,
                                            primaryColor: state
                                                .settingsModel.primaryColor,
                                            fontFamily: val,
                                          ),
                                          state.settingsModel,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      ),
    );
  }
}
