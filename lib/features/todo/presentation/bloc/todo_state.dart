import 'package:equatable/equatable.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class InitialTodoState extends TodoState {
  @override
  List<Object> get props => [];
}
