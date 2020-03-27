import 'package:equatable/equatable.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

class Notification extends Equatable {
  final TODOModel data;
  final int id;

  Notification(this.data, this.id);

  @override
  List<Object> get props => [data];
}
