import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_bloc.dart';
import 'package:todoapp/features/authetification/presenation/bloc/auth_state.dart';

bool isRegistered(BuildContext context) {
  final state = BlocProvider.of<AuthBloc>(context).state;
  if (state is Entered) {
    if (state.user is UsualUserModel) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
