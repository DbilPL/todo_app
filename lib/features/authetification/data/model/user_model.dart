import 'package:flutter/cupertino.dart';
import 'package:todoapp/features/authetification/domain/enteties/user.dart';

class UserModel extends User {
  final String uid;

  UserModel({@required this.uid}) : super(uid: uid);
}
