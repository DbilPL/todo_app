import 'package:equatable/equatable.dart';
import 'package:todoapp/features/todo/domain/entities/todo.dart';

class TODOList extends Equatable {
  final String groupName;

  final List<TODO> todoList;

  TODOList(this.groupName, this.todoList);

  @override
  List<Object> get props => [groupName, todoList];
}
