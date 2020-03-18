import 'package:flutter/cupertino.dart';
import 'package:todoapp/features/authetification/domain/enteties/user.dart';

class UserModel extends User {
  UserModel();

  @override
  List<Object> get props => [];
}

class UsualUserModel extends UserModel {
  final String uid, email, password;

  UsualUserModel({
    this.uid,
    @required this.email,
    @required this.password,
  }) : super();

  Map<String, dynamic> toJSON() {
    return {
      "email": this.email,
      "password": this.password,
    };
  }

  static fromJSON(Map<String, dynamic> json) {
    return UsualUserModel(
      email: json['email'],
      password: json['password'],
    );
  }

  @override
  List<Object> get props => [uid, email, password];
}

class NoAccountUser extends UserModel {
  NoAccountUser() : super();

  @override
  List<Object> get props => [];
}
