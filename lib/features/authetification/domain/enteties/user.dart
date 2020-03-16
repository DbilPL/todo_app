import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class User extends Equatable {
  final String uid;

  User({
    @required this.uid,
  });

  @override
  List<Object> get props => [uid];
}
