import 'package:equatable/equatable.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

class TODOList extends Equatable {
  final String groupName;

  final List<TODOModel> todoList;

  const TODOList(this.groupName, this.todoList);

  @override
  List<Object> get props => [groupName, todoList];
}
