import 'package:equatable/equatable.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';

abstract class TodoState extends Equatable {
  final List<TODOGroupModel> list;

  const TodoState(this.list);
}

class FailureTodoState extends TodoState {
  final String error;
  final List<TODOGroupModel> list;

  FailureTodoState(this.error, this.list) : super(list);

  @override
  List<Object> get props => [error];
}

class FailureTodoStateInitial extends TodoState {
  final String error;
  final List<TODOGroupModel> list;

  FailureTodoStateInitial(this.error, this.list) : super(list);

  @override
  List<Object> get props => [error];
}

class AreYouSureForDeletingAllTodo extends TodoState {
  AreYouSureForDeletingAllTodo(List<TODOGroupModel> list) : super(list);

  @override
  List<Object> get props => [list];
}

class TodoUpdated extends TodoState {
  final List<TODOGroupModel> list;

  TodoUpdated(this.list) : super(list);

  @override
  List<Object> get props => [list];
}

class LoadingTodoState extends TodoState {
  LoadingTodoState(List<TODOGroupModel> list) : super(list);

  @override
  List<Object> get props => [list];
}

class InitialTodoState extends TodoState {
  InitialTodoState(List<TODOGroupModel> list) : super(list);

  @override
  List<Object> get props => [list];
}
