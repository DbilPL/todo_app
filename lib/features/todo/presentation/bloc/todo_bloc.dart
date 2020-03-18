import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  @override
  TodoState get initialState => InitialTodoState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
