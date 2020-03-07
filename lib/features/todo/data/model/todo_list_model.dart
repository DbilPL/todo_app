import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';
import 'package:todoapp/features/todo/domain/entities/todo_list.dart';

class TODOGroupModel extends TODOList {
  TODOGroupModel(String groupName, List<TODO> todoList)
      : super(groupName, todoList);

  static TODOGroupModel fromJson(Map<String, dynamic> json) {
    return TODOGroupModel(
      json['groupName'],
      List.generate(
        json['list'].length,
        (index) {
          return TODOModel(
            body: json['list'][index]['body'],
            isComplete: json['list'][index]['isComplete'],
            title: json['list'][index]['title'],
            date: DateTime(
              json['list'][index]['date'][0],
              json['list'][index]['date'][1],
              json['list'][index]['date'][2],
              json['list'][index]['date'][3],
              json['list'][index]['date'][4],
            ),
          );
        },
      ),
    );
  }

  static Map<String, dynamic> toJson(TODOGroupModel model) {
    Map<String, dynamic> json = {};

    json['title'] = model.groupName;

    for (int i = 0; i < model.todoList.length; i++) {
      json['list'][i]['body'] = model.todoList[i].body;
      json['list'][i]['title'] = model.todoList[i].title;
      json['list'][i]['isComplete'] = model.todoList[i].isComplete;
      json['list'][i]['date'][0] = model.todoList[i].date.year;
      json['list'][i]['date'][1] = model.todoList[i].date.month;
      json['list'][i]['date'][2] = model.todoList[i].date.day;
      json['list'][i]['date'][3] = model.todoList[i].date.hour;
      json['list'][i]['date'][4] = model.todoList[i].date.minute;
      json['list'][i]['date'][5] = model.todoList[i].date.second;
    }
  }
}
