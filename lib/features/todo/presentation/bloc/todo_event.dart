import 'package:equatable/equatable.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

abstract class TodoEvent extends Equatable {
  final List<TODOGroupModel> list;

  const TodoEvent(this.list);
}

class TodoFailure extends TodoEvent {
  final List<TODOGroupModel> list;

  final String error;

  TodoFailure(this.error, this.list) : super(list);

  @override
  List<Object> get props => [list];
}

class DeleteTodoGroupLocal extends TodoEvent {
  final String groupName;
  final List<TODOGroupModel> list;
  DeleteTodoGroupLocal(this.groupName, this.list) : super(list);

  @override
  List<Object> get props => [groupName, list];
}

class AddTodoToGroupLocal extends TodoEvent {
  final String groupName, title, body, date;

  final List<TODOGroupModel> list;

  AddTodoToGroupLocal(
      this.groupName, this.title, this.body, this.date, this.list)
      : super(list);

  @override
  List<Object> get props => [title, body, date, list];
}

class TodoChangeStatusLocal extends TodoEvent {
  final List<TODOGroupModel> list;
  final String groupTitle;
  final TODOModel todo;

  TodoChangeStatusLocal(this.list, this.groupTitle, this.todo) : super(list);

  @override
  List<Object> get props => [list, groupTitle, todo];
}

class DeleteTodoLocal extends TodoEvent {
  final String groupTitle;
  final String todoTitle;
  final List<TODOGroupModel> list;
  DeleteTodoLocal(this.todoTitle, this.groupTitle, this.list) : super(list);

  @override
  List<Object> get props => [this.groupTitle, this.todoTitle, this.list];
}

class DeleteAllTodoLocal extends TodoEvent {
  final bool areYouSure;

  DeleteAllTodoLocal(List<TODOGroupModel> list, this.areYouSure) : super(list);

  @override
  List<Object> get props => [list];
}

class LoadLocalTodoInitialLocal extends TodoEvent {
  LoadLocalTodoInitialLocal(List<TODOGroupModel> list) : super(list);

  @override
  List<Object> get props => [];
}

class ReorderListLocal extends TodoEvent {
  final List<TODOGroupModel> list;
  final int oldIndex, newIndex;
  ReorderListLocal(this.list, this.oldIndex, this.newIndex) : super(list);

  @override
  List<Object> get props => [list, oldIndex, newIndex];
}

class AddTodoGroupLocal extends TodoEvent {
  final String title;
  final List<TODOGroupModel> prevList;

  AddTodoGroupLocal(this.title, this.prevList) : super(prevList);

  @override
  List<Object> get props => [title];
}
