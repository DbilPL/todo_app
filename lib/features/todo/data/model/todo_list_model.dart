import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/entities/todo_list.dart';

class TODOGroupModel extends TODOList {
  final int uniqueID;

  TODOGroupModel(String groupName, List<TODOModel> todoList, this.uniqueID)
      : super(groupName, todoList);

  static TODOGroupModel fromJson(Map<String, dynamic> json) {
    return TODOGroupModel(
      json['title'],
      json['list'] != []
          ? List.generate(
              json['list'].length,
              (index) {
                return TODOModel.fromJson(json['list'][index]);
              },
            )
          : [],
      json['uniqueID'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['title'] = this.groupName;

    json['uniqueID'] = this.uniqueID;

    json['list'] = [];

    if (this.todoList != null &&
        this.todoList != [] &&
        this.todoList.length != 0)
      for (int i = 0; i < this.todoList.length; i++) {
        json['list'].add(this.todoList[i].toJson());
      }
    else
      json['list'] = [];

    return json;
  }
}
