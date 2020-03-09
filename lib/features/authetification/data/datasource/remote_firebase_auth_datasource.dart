import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

///// Uses [FlutterSecureStorage] to get count of times, when user entered
///// Returns [int], if success, returns [CacheException] when something went wrong
//Future<int> timesOfEnter();
//
///// Uses [FlutterSecureStorage] to increase count of times, when user entered
///// Returns [int], if success, returns [CacheException] when something went wrong
//Future<int> increaseTimesOfEnter();
//
///// Uses [FlutterSecureStorage] to get [TODOModel] list of list
///// Returns list of them, if success, returns [CacheException] when something went wrong
//Future<List<List<TODOModel>>> getTODOList();
//
///// Uses [FlutterSecureStorage] to write [TODOModel] list of list on local cache
///// Returns [CacheException] when something went wrong
//Future<void> writeTODOList(List<List<TODOModel>> todos);

abstract class FirebaseAuthDatasource {
  /// Uses [FirebaseAuth] to sign in anonim
  /// Returns [FirebaseUser], if success, returns [CacheException] when something went wrong
  Future<FirebaseUser> signInAnon();
}

const SETTINGS_KEY = 'settings';

class FirebaseAuthDatasourceImpl extends FirebaseAuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasourceImpl(this._auth);

  @override
  Future<FirebaseUser> signInAnon() async {
    AuthResult result = await _auth.signInAnonymously();

    return result.user;
  }
}
