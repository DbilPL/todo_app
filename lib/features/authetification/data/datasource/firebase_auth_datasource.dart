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

const String _authKey = 'authentification';

class FirebaseAuthDatasourceImpl extends FirebaseAuthDatasource {
  final FirebaseAuth _auth;
  final SharedPreferences _sharedPreferences;

  FirebaseAuthDatasourceImpl(this._auth, this._sharedPreferences);

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<UsualUserModel> _authenticate(
      {String email,
      String password,
      Future<AuthResult> Function({String email, String password})
          function}) async {
    final result = await function(email: email, password: password);

    final user = UsualUserModel(
      password: password,
      email: email,
      uid: result.user.uid,
    );

    await _sharedPreferences.setString(_authKey, jsonEncode(user.toJSON()));

    return user;
  }

  @override
  Future<UsualUserModel> signIn({String email, String password}) {
    return _authenticate(
        email: email,
        password: password,
        function: _auth.signInWithEmailAndPassword);
  }

  @override
  Future<UsualUserModel> register({String email, String password}) async {
    return _authenticate(
        email: email,
        password: password,
        function: _auth.signInWithEmailAndPassword);
  }

  @override
  Future<UsualUserModel> signInAuto() async {
    final lUser = UsualUserModel.fromJSON(
      jsonDecode(
        _sharedPreferences.getString(_authKey),
      ) as Map<String, dynamic>,
    );

    final AuthResult result = await _auth.signInWithEmailAndPassword(
        email: lUser.email, password: lUser.password);

    return lUser.copyWith(uid: result.user.uid);
  }
}
