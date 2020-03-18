import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class FirebaseAuthDatasource {
  /// Uses [FirebaseAuth] to sign out
  /// Returns [FirebaseFailure] when something went wrong
  Future<void> signOut();

  /// Uses [FirebaseAuth] to sign in to existing account
  /// If success, returns [UsualUserModel], if failure, returns [FirebaseFailure]
  Future<UsualUserModel> signIn({String email, String password});

  /// Uses [FirebaseAuth] to create new account
  /// If success, returns [UsualUserModel], if failure, returns [FirebaseFailure]
  Future<UsualUserModel> register({String email, String password});

  /// Uses [SharedPreferences] to find out already-registered user data and using [FirebaseAuth] enter automatically
  /// If success, returns [UsualUserModel], if failure, returns [FirebaseFailure] either [CacheFailure]
  Future<UsualUserModel> signInAuto();
}

const AUTH_KEY = 'authentification';

class FirebaseAuthDatasourceImpl extends FirebaseAuthDatasource {
  final FirebaseAuth _auth;
  final SharedPreferences sharedPreferences;

  FirebaseAuthDatasourceImpl(this._auth, this.sharedPreferences);

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  Future<UsualUserModel> signIn({String email, String password}) async {
    final AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    await sharedPreferences.setString(
        AUTH_KEY,
        jsonEncode(UsualUserModel(
          password: password,
          email: email,
          uid: result.user.uid,
        ).toJSON()));

    return UsualUserModel(
        email: result.user.email, uid: result.user.uid, password: password);
  }

  @override
  Future<UsualUserModel> register({String email, String password}) async {
    final AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await sharedPreferences.setString(AUTH_KEY,
        jsonEncode(UsualUserModel(password: password, email: email).toJSON()));

    return UsualUserModel(
        password: password, email: email, uid: result.user.uid);
  }

  @override
  Future<UsualUserModel> signInAuto() async {
    UsualUserModel lUser = UsualUserModel.fromJSON(
      jsonDecode(
        sharedPreferences.getString(AUTH_KEY),
      ),
    );

    print(lUser.email);
    print(lUser.password);

    final AuthResult result = await _auth.signInWithEmailAndPassword(
        email: lUser.email, password: lUser.password);

    return UsualUserModel(
        password: lUser.password, email: lUser.email, uid: result.user.uid);
  }
}
