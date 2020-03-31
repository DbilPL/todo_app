import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/methods.dart';
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
                final isUserRegistered = isRegistered(context);

                if (state is Entered) {
                  return ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(''),
                        accountEmail: Text(
                          isUserRegistered ? state.user.props[1] : 'Anonymous',
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
            if (state is LoadingSettingsState)
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );

            if (state is CacheFailureState) {
              Navigator.of(context).pop();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Something went wrong!',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is ConnectionFailureState) {
              Navigator.of(context).pop();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'You have no connection to internet!',
                    style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
            if (state is SettingsUpdated) {
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, _state) {
              final isUserRegistered = isRegistered(context);

              if (_state is Entered) {
                return BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Background color',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.caption.color,
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

                                if (isUserRegistered) {
                                  BlocProvider.of<SettingsBloc>(context).add(
                                    SetSettingsRemoteEvent(
                                      settings: newSettings,
                                      prevSettings: state.settingsModel,
                                      uid: _state.user.props[0],
                                    ),
                                  );
                                } else
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

                                if (isUserRegistered) {
                                  BlocProvider.of<SettingsBloc>(context).add(
                                    SetSettingsRemoteEvent(
                                      settings: newSettings,
                                      prevSettings: state.settingsModel,
                                      uid: _state.user.props[0],
                                    ),
                                  );
                                } else
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
                              color: Theme.of(context).textTheme.caption.color,
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
                                      if (isUserRegistered) {
                                        BlocProvider.of<SettingsBloc>(context)
                                            .add(
                                          SetSettingsRemoteEvent(
                                            settings: SettingsModel(
                                              primaryColor: val,
                                              backgroundColor: state
                                                  .settingsModel
                                                  .backgroundColor,
                                              fontColor:
                                                  state.settingsModel.fontColor,
                                              fontFamily: state
                                                  .settingsModel.fontFamily,
                                            ),
                                            prevSettings: state.settingsModel,
                                            uid: _state.user.props[0],
                                          ),
                                        );
                                      } else
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
                              color: Theme.of(context).textTheme.caption.color,
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
                                    if (isUserRegistered) {
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(
                                        SetSettingsRemoteEvent(
                                          settings: SettingsModel(
                                            backgroundColor: state
                                                .settingsModel.backgroundColor,
                                            fontColor:
                                                state.settingsModel.fontColor,
                                            primaryColor: state
                                                .settingsModel.primaryColor,
                                            fontFamily: val,
                                          ),
                                          prevSettings: state.settingsModel,
                                          uid: _state.user.props[0],
                                        ),
                                      );
                                    } else
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(
                                        SetSettingsLocalEvent(
                                          SettingsModel(
                                            primaryColor: state
                                                .settingsModel.primaryColor,
                                            backgroundColor: state
                                                .settingsModel.backgroundColor,
                                            fontColor:
                                                state.settingsModel.fontColor,
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
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
