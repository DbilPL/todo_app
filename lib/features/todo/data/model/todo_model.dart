import 'package:flutter/cupertino.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';

class TODOModel extends TODO {
  final String title, body;

  final DateTime date;

  final bool isComplete;

  TODOModel(
      {@required this.isComplete,
      @required this.date,
      @required this.title,
      @required this.body})
      : super(
          isComplete: isComplete,
          date: date,
          title: title,
          body: body,
        );

  @override
  List<Object> get props => [title, body, date, isComplete];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'isComplete': isComplete,
      'date': [
        date.year,
        date.month,
        date.hour,
        date.minute,
        date.second,
      ],
    };
  }
}
