import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/core/errors/exceptions.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';

abstract class TODOLocalDatasource {
  /// Use [SharedPreferences] to get current [TODO] list
  /// Returns [TODOGroupModel], if success, returns [CacheException] when something went wrong
  List<TODOGroupModel> getCurrentTODO();

  /// Use [SharedPreferences] to set [TODO] list
  /// Returns [CacheException] when something went wrong
  Future<void> setCurrentTODO(List<TODOGroupModel> todogModel);
}

const String _todoKey = 'todo';

class TODOLocalDatasourceImpl implements TODOLocalDatasource {
  final SharedPreferences _storage;

  TODOLocalDatasourceImpl(this._storage);

  @override
  List<TODOGroupModel> getCurrentTODO() {
    final List<TODOGroupModel> list = [];

    final todo = _storage.getStringList(_todoKey);

    if (todo != null) {
      for (int i = 0; i < todo.length; i++) {
        final map = json.decode(todo[i]) as Map<String, dynamic>;

        list.add(
          TODOGroupModel.fromJson(
            map,
          ),
        );
      }
    }

    return list;
  }

  @override
  Future<void> setCurrentTODO(List<TODOGroupModel> todogModel) async {
    final List<String> todo = List.generate(
      todogModel.length,
      (index) {
        final mapStr = todogModel[index].toJson();

        return json.encode(mapStr);
      },
    );

    await _storage.setStringList(_todoKey, todo);
  }
}
