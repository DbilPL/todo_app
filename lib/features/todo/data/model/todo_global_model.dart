import 'package:todoapp/features/todo/data/model/todo_model.dart';

class TODOGModel {
  final List<TODOModel> TODOList;

  TODOGModel(this.TODOList);

  static TODOGModel fromJSON(Map<String, dynamic> todo) {
    List<TODOModel> list = [];

    for (int i = 0; i < todo['list'].length; i++) {
      list.add(
        TODOModel(
          title: todo['list'][i]['title'],
          body: todo['list'][i]['body'],
          isComplete: todo['list'][i]['isComplete'],
          date: DateTime(
            todo['list'][i]['date'][0],
            todo['list'][i]['date'][1],
            todo['list'][i]['date'][2],
            todo['list'][i]['date'][3],
            todo['list'][i]['date'][4],
            todo['list'][i]['date'][5],
            todo['list'][i]['date'][6],
            todo['list'][i]['date'][7],
          ),
        ),
      );
    }

    return TODOGModel(list);
  }

  static Map<String, dynamic> toJSON(TODOGModel todogModel) {
    Map<String, dynamic> json = {};

    for (int i = 0; i < todogModel.TODOList.length; i++) {
      json['list'][i]['title'] = todogModel.TODOList[i].title;
      json['list'][i]['body'] = todogModel.TODOList[i].body;
      json['list'][i]['isComplete'] = todogModel.TODOList[i].isComplete;
      json['list'][i]['date'][0] = todogModel.TODOList[i].date.year;
      json['list'][i]['date'][1] = todogModel.TODOList[i].date.month;
      json['list'][i]['date'][2] = todogModel.TODOList[i].date.weekday;
      json['list'][i]['date'][3] = todogModel.TODOList[i].date.day;
      json['list'][i]['date'][4] = todogModel.TODOList[i].date.hour;
      json['list'][i]['date'][5] = todogModel.TODOList[i].date.second;
      json['list'][i]['date'][6] = todogModel.TODOList[i].date.millisecond;
      json['list'][i]['date'][7] = todogModel.TODOList[i].date.microsecond;
    }

    return json;
  }
}
