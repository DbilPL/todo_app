import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/features/todo/data/model/todo_global_model.dart';

abstract class TODOLocalDatasource {
  /// Use [SharedPreferences] to get current [TODO] list
  /// Returns [TODOGModel], if success, returns [CacheException] when something went wrong
  TODOGModel getCurrentTODO();

  /// Use [SharedPreferences] to set [TODO] list
  /// Returns [CacheException] when something went wrong
  Future<void> setCurrentTODO(TODOGModel todogModel);
}

const String TODO_KEY = 'todo';

class TODOLocalDatasourceImpl implements TODOLocalDatasource {
  final SharedPreferences storage;

  TODOLocalDatasourceImpl(this.storage);

  @override
  TODOGModel getCurrentTODO() {
    final todo = json.decode(storage.getString(TODO_KEY));

    return TODOGModel.fromJSON(todo);
  }

  @override
  Future<void> setCurrentTODO(TODOGModel todogModel) async {
    final Map<String, dynamic> todo = TODOGModel.toJSON(todogModel);

    await storage.setString(
      TODO_KEY,
      json.encode(todo),
    );
  }
}
