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

  const TodoFailure(this.error, this.list) : super(list);

  @override
  List<Object> get props => [list];
}

class DeleteTodoGroupLocal extends TodoEvent {
  final String groupName;
  final List<TODOGroupModel> list;
  final List<int> ids;
  const DeleteTodoGroupLocal(this.groupName, this.list, this.ids) : super(list);

  @override
  List<Object> get props => [groupName, list];
}

class DeleteTodoGroupRemote extends TodoEvent {
  final String groupName;
  final List<int> ids;
  final String uid;
  const DeleteTodoGroupRemote(
      this.groupName, List<TODOGroupModel> list, this.ids, this.uid)
      : super(list);

  @override
  List<Object> get props => [groupName, list];
}

class AddTodoToGroupLocal extends TodoEvent {
  final String groupName, title, body, date;
  final int id;

  const AddTodoToGroupLocal(
    this.groupName,
    this.title,
    this.body,
    this.date,
    List<TODOGroupModel> list,
    this.id,
  ) : super(list);

  @override
  List<Object> get props => [title, body, date, list];
}

class AddTodoToGroupRemote extends TodoEvent {
  final String groupName, title, body, date;
  final int id;
  final String uid;

  const AddTodoToGroupRemote(
    this.groupName,
    this.title,
    this.body,
    this.date,
    List<TODOGroupModel> list,
    this.id,
    this.uid,
  ) : super(list);

  @override
  List<Object> get props => [title, body, date, list];
}

class TodoChangeStatusLocal extends TodoEvent {
  final String groupTitle;
  final TODOModel todo;
  final int id;

  const TodoChangeStatusLocal(
      List<TODOGroupModel> list, this.groupTitle, this.todo, this.id)
      : super(list);

  @override
  List<Object> get props => [list, groupTitle, todo];
}

class TodoChangeStatusRemote extends TodoEvent {
  final String groupTitle;
  final TODOModel todo;
  final int id;
  final String uid;

  const TodoChangeStatusRemote(
      List<TODOGroupModel> list, this.groupTitle, this.todo, this.id, this.uid)
      : super(list);

  @override
  List<Object> get props => [list, groupTitle, todo];
}

class DeleteTodoLocal extends TodoEvent {
  final String groupTitle;
  final String todoTitle;
  final int id;
  const DeleteTodoLocal(
      this.todoTitle, this.groupTitle, List<TODOGroupModel> list, this.id)
      : super(list);

  @override
  List<Object> get props => [this.groupTitle, this.todoTitle, this.list];
}

class DeleteTodoRemote extends TodoEvent {
  final String groupTitle;
  final String todoTitle;
  final int id;
  final String uid;
  const DeleteTodoRemote(this.todoTitle, this.groupTitle,
      List<TODOGroupModel> list, this.id, this.uid)
      : super(list);

  @override
  List<Object> get props => [this.groupTitle, this.todoTitle, this.list];
}

class DeleteAllTodoLocal extends TodoEvent {
  final bool areYouSure;

  const DeleteAllTodoLocal(List<TODOGroupModel> list, {this.areYouSure})
      : super(list);

  @override
  List<Object> get props => [list];
}

class DeleteAllTodoRemote extends TodoEvent {
  final bool areYouSure;
  final String uid;

  const DeleteAllTodoRemote(List<TODOGroupModel> list, this.uid,
      {this.areYouSure})
      : super(list);

  @override
  List<Object> get props => [list];
}

class LoadLocalTodoInitial extends TodoEvent {
  const LoadLocalTodoInitial(List<TODOGroupModel> list) : super(list);

  @override
  List<Object> get props => [];
}

class LoadRemoteTodoInitial extends TodoEvent {
  final String uid;

  const LoadRemoteTodoInitial(List<TODOGroupModel> list, this.uid)
      : super(list);

  @override
  List<Object> get props => [];
}

class SetRemoteTodoInitial extends TodoEvent {
  final String uid;

  final List<TODOGroupModel> prevList;

  const SetRemoteTodoInitial(List<TODOGroupModel> list, this.uid, this.prevList)
      : super(list);

  @override
  List<Object> get props => [];
}

class ReorderListLocal extends TodoEvent {
  final List<TODOGroupModel> list;
  final int oldIndex, newIndex;
  const ReorderListLocal(this.list, this.oldIndex, this.newIndex) : super(list);

  @override
  List<Object> get props => [list, oldIndex, newIndex];
}

class ReorderListRemote extends TodoEvent {
  final int oldIndex, newIndex;
  final String uid;
  const ReorderListRemote(
      List<TODOGroupModel> list, this.oldIndex, this.newIndex, this.uid)
      : super(list);

  @override
  List<Object> get props => [list, oldIndex, newIndex];
}

class AddTodoGroupLocal extends TodoEvent {
  final String title;
  final int uniqueID;
  final List<TODOGroupModel> prevList;

  const AddTodoGroupLocal(this.title, this.prevList, this.uniqueID)
      : super(prevList);

  @override
  List<Object> get props => [title, uniqueID];
}

class AddTodoGroupRemote extends TodoEvent {
  final String title;
  final List<TODOGroupModel> prevList;
  final String uid;
  final int uniqueID;

  const AddTodoGroupRemote(this.title, this.prevList, this.uid, this.uniqueID)
      : super(prevList);

  @override
  List<Object> get props => [title, uid, uniqueID];
}
