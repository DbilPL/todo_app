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

  static TODOModel fromJson(Map<String, dynamic> json) {
    return TODOModel(
      isComplete: json['isComplete'],
      title: json['title'],
      body: json['body'],
      date: json['date'] != null
          ? DateTime(
              json['date'][0],
              json['date'][1],
              json['date'][2],
              json['date'][3],
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'body': this.body,
      'isComplete': this.isComplete,
      'date': this.date != null
          ? [
              this.date.year,
              this.date.month,
              this.date.hour,
              this.date.minute,
            ]
          : null,
    };
  }
}
