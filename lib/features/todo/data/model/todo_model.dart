import 'package:todoapp/features/todo/domain/entities/todo.dart';

class TODOModel extends TODO {
  const TODOModel({
    bool isComplete,
    DateTime date,
    String title,
    String body,
  }) : super(
          isComplete: isComplete,
          date: date,
          title: title,
          body: body,
        );

  TODOModel copyWith({
    bool isComplete,
    DateTime date,
    String title,
    String body,
  }) {
    return TODOModel(
      body: body ?? this.body,
      date: date ?? this.date,
      isComplete: isComplete ?? this.isComplete,
      title: title ?? this.title,
    );
  }

  @override
  List<Object> get props => [title, body, date, isComplete];

  factory TODOModel.fromJson(Map<String, dynamic> json) {
    return TODOModel(
      isComplete: json['isComplete'] as bool,
      title: json['title'] as String,
      body: json['body'] as String,
      date: json['date'] != null
          ? DateTime(
              json['date'][0] as int,
              json['date'][1] as int,
              json['date'][2] as int,
              json['date'][3] as int,
            )
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'isComplete': isComplete,
      'date': date != null
          ? [
              date.year,
              date.month,
              date.hour,
              date.minute,
            ]
          : null,
    };
  }
}
