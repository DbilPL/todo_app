import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/entities/todo_list.dart';

class TODOGroupModel extends TODOList {
  final int uniqueID;

  TODOGroupModel(String groupName, List<TODOModel> todoList, this.uniqueID)
      : super(groupName, todoList);

  static TODOGroupModel fromJson(Map<String, dynamic> json) {
    return TODOGroupModel(
      json['title'] as String,
      json['list'] != []
          ? List.generate(
              json['list'].length as int,
              (index) {
                final map = json['list'][index] as Map<String, dynamic>;

                return TODOModel.fromJson(map);
              },
            )
          : [],
      json['uniqueID'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json['title'] = groupName;

    json['uniqueID'] = uniqueID;

    json['list'] = [];

    if (todoList != null && todoList.isNotEmpty) {
      for (int i = 0; i < todoList.length; i++) {
        final map = todoList[i].toJson();

        json['list'].add(map);
      }
    } else {
      json['list'] = [];
    }

    return json;
  }
}
