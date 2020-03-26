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

const String TODO_KEY = 'todo';

class TODOLocalDatasourceImpl implements TODOLocalDatasource {
  final SharedPreferences storage;

  TODOLocalDatasourceImpl(this.storage);

  @override
  List<TODOGroupModel> getCurrentTODO() {
    List<TODOGroupModel> list = [];
    final todo = storage.getStringList(TODO_KEY);

    if (todo != null) {
      for (int i = 0; i < todo.length; i++) {
        list.add(
          TODOGroupModel.fromJson(
            json.decode(todo[i]),
          ),
        );
      }
    }

    return list;
  }

  @override
  Future<void> setCurrentTODO(List<TODOGroupModel> todogModel) async {
    print(todogModel.length);

    List<String> todo = List.generate(
      todogModel.length,
      (index) {
        print(index);
        return json.encode(
          todogModel[index].toJson(),
        );
      },
    );

    print('set');

    print(todo);

    await storage.setStringList(TODO_KEY, todo);
  }
}
