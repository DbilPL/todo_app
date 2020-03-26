import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/usecases/get_local_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/set_local_todo.dart';

import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetLocalTodo _getLocalTodo;
  final SetLocalTODO _setLocalTODO;

  TodoBloc(this._getLocalTodo, this._setLocalTODO);

  @override
  TodoState get initialState => InitialTodoState([]);

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    yield LoadingTodoState(event.list);

    if (event is LoadLocalTodoInitialLocal) {
      try {
        final todoOrFailure = await _getLocalTodo(NoParams());

        yield await todoOrFailure.fold((failure) async {
          print('something went wrong!');
          print(failure.error);
          final setTodoOrFailure = await _setLocalTODO([]);

          return setTodoOrFailure.fold((failure) {
            return FailureTodoState(failure.error, []);
          }, (success) {
            return TodoUpdated([]);
          });
        }, (todos) {
          print(todos);
          print('success');
          return TodoUpdated(todos);
        });
      } catch (e) {
        print('no data');

        final setTodoOrFailure = await _setLocalTODO([]);

        yield setTodoOrFailure.fold((failure) {
          return FailureTodoState(failure.error, []);
        }, (success) {
          return TodoUpdated([]);
        });
      }
    }
    if (event is ReorderListLocal) {
      if (event.oldIndex == (event.newIndex - 1)) {
        yield TodoUpdated(event.list);
      } else {
        final newList = event.list;

        final newIndex =
            event.newIndex > 1 ? event.newIndex - 1 : event.newIndex;

        print(event.oldIndex);
        print(event.newIndex);

        final oldItem = newList[event.oldIndex];

        newList[event.oldIndex] = newList[newIndex];

        newList[newIndex] = oldItem;

        final saveOrFailure = await _setLocalTODO(newList);

        yield saveOrFailure.fold((failure) {
          return FailureTodoState(failure.error, event.list);
        }, (success) {
          return TodoUpdated(newList);
        });
      }
    }
    if (event is AddTodoGroupLocal) {
      bool isExist = false;

      for (int i = 0; i < event.prevList.length; i++) {
        if (event.prevList[i].groupName == event.title) {
          isExist = true;

          break;
        }
      }

      if (!isExist) {
        final newList = event.prevList
          ..add(
            TODOGroupModel(
              event.title,
              [],
            ),
          );

        final setTodoOrFailure = await _setLocalTODO(newList);

        yield setTodoOrFailure.fold(
          (failure) {
            print('something went wrong!');
            return FailureTodoState(failure.error, event.prevList);
          },
          (success) {
            print('success');
            print(newList);
            return TodoUpdated(newList);
          },
        );
      } else
        yield FailureTodoState('This group already exist!', event.prevList);
    }

    if (event is TodoFailure) {
      yield FailureTodoState(event.error, event.list);
    }

    if (event is DeleteTodoGroupLocal) {
      List<TODOGroupModel> list;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupName) {
          list = event.list..removeAt(i);
        }
      }
      print(list.toString());

      final setOrSuccess = await _setLocalTODO(list);

      yield setOrSuccess.fold((failure) {
        return FailureTodoState('Something went wrong! Try again!', event.list);
      }, (success) {
        return TodoUpdated(list);
      });

      yield TodoUpdated(list);
    }

    if (event is AddTodoToGroupLocal) {
      final List<int> date = event.date != ''
          ? event.date.split('/').map((val) => int.parse(val)).toList()
          : null;
      final newTodo = TODOModel(
        title: event.title,
        body: event.body,
        date: date != null
            ? DateTime(
                date[0],
                date[1],
                date[2],
                date[3],
                date[4],
              )
            : date,
        isComplete: false,
      );

      bool isExist = false;

      List<TODOGroupModel> list = event.list;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupName) {
          for (int j = 0; j < event.list[i].todoList.length; j++) {
            if (event.list[i].todoList[j].title == newTodo.title) {
              isExist = true;
              break;
            }
          }
          if (!isExist) {
            list[i].todoList.add(newTodo);
          } else {
            yield FailureTodoState(
                'This todo already exist in that group!', event.list);

            break;
          }
        }

        if (!isExist) {
          final setOrSuccess = await _setLocalTODO(list);

          yield setOrSuccess.fold(
            (failure) {
              print('failure');
              return FailureTodoState(failure.error, event.list);
            },
            (success) {
              return TodoUpdated(list);
            },
          );
        }
      }
    }

    if (event is DeleteAllTodoLocal) {
      if (!event.areYouSure)
        yield AreYouSureForDeletingAllTodo(event.list);
      else {
        final deleteOrSuccess = await _setLocalTODO([]);

        yield deleteOrSuccess.fold((failure) {
          return FailureTodoState(failure.error, event.list);
        }, (success) {
          return TodoUpdated([]);
        });
      }
    }

    if (event is TodoChangeStatusLocal) {
      List<TODOGroupModel> list = event.list;

      for (int j = 0; j < list.length; j++) {
        final todos = list[j];
        if (todos.groupName == event.groupTitle) {
          for (int i = 0; i < todos.todoList.length; i++) {
            if (todos.todoList[i].title == event.todo.title) {
              list[j].todoList[i] = TODOModel(
                title: event.todo.title,
                body: event.todo.body,
                date: event.todo.date,
                isComplete: !event.todo.isComplete,
              );
              break;
            }
          }
        }
      }

      final setOrSuccess = await _setLocalTODO(list);

      yield setOrSuccess.fold((failure) {
        return FailureTodoState(failure.error, event.list);
      }, (success) {
        return TodoUpdated(list);
      });
    }

    if (event is DeleteTodoLocal) {
      final list = event.list;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupTitle) {
          for (int j = 0; j < event.list[i].todoList.length; j++) {
            if (event.list[i].todoList[j].title == event.todoTitle) {
              list[i].todoList.removeAt(j);
            }
          }
        }
      }

      final setOrSuccess = await _setLocalTODO(list);

      yield setOrSuccess.fold(
          (failure) => FailureTodoState(failure.error, event.list),
          (success) => TodoUpdated(list));
    }
  }
}
