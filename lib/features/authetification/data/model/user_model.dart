import 'package:flutter/cupertino.dart';

import 'package:todoapp/features/authetification/domain/enteties/user.dart';

class UserModel extends User {
  const UserModel();

  @override
  List<Object> get props => [];
}

class UsualUserModel extends UserModel {
  final String uid, email, password;

  const UsualUserModel({
    this.uid,
    @required this.email,
    @required this.password,
  }) : super();

  Map<String, dynamic> toJSON() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UsualUserModel.fromJSON(Map<String, dynamic> json) {
    return UsualUserModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  @override
  List<Object> get props => [uid, email, password];

  UsualUserModel copyWith({
    String uid,
    String email,
    String password,
  }) {
    return UsualUserModel(
      password: password ?? this.password,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }
}

class NoAccountUser extends UserModel {
  const NoAccountUser() : super();

  @override
  List<Object> get props => [];
}
