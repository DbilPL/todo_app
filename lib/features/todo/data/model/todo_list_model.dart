import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/entities/todo_list.dart';

class TODOGroupModel extends TODOList {
  TODOGroupModel(String groupName, List<TODOModel> todoList)
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
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['title'] = this.groupName;

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
