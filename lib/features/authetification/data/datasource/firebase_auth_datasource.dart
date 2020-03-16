import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/features/authetification/data/model/user_model.dart';

abstract class FirebaseAuthDatasource {
  /// Uses [FirebaseAuth] to sign in anonim
  /// Returns [UserModel], if success, returns [FirebaseFailure] when something went wrong
  Future<UserModel> signInAnon();

  /// Uses [FirebaseAuth] to sign out
  /// Returns [FirebaseFailure] when something went wrong
  Future<void> signOut();
}

const AUTH_KEY = 'authentification';

class FirebaseAuthDatasourceImpl extends FirebaseAuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasourceImpl(this._auth);

  @override
  Future<UserModel> signInAnon() async {
    AuthResult result = await _auth.signInAnonymously();

    return result != null ? UserModel(uid: result.user.uid) : null;
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
