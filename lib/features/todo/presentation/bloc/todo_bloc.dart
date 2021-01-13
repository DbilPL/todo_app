import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/notifications/data/models/notifications_model.dart';
import 'package:todoapp/features/notifications/domain/usecases/cancel_all_notifications.dart';
import 'package:todoapp/features/notifications/domain/usecases/cancel_notification.dart';
import 'package:todoapp/features/notifications/domain/usecases/set_notification.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/data/repository/todo_remote_repository_impl.dart';
import 'package:todoapp/features/todo/domain/usecases/get_local_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/get_remote_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/set_local_todo.dart';
import 'package:todoapp/features/todo/domain/usecases/update_remote_todo.dart';

import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetLocalTodo _getLocalTodo;
  final SetLocalTODO _setLocalTODO;
  final GetRemoteTODO _getRemoteTODO;
  final UpdateRemoteTODO _updateRemoteTODO;
  final CancelNotificationLocal _cancelNotificationLocal;
  final SetNotificationLocal _setNotificationLocal;
  final CancelAllNotificationsLocal _cancelAllNotificationsLocal;

  TodoBloc(
    this._getLocalTodo,
    this._setLocalTODO,
    this._cancelNotificationLocal,
    this._setNotificationLocal,
    this._cancelAllNotificationsLocal,
    this._getRemoteTODO,
    this._updateRemoteTODO,
  );

  @override
  TodoState get initialState => InitialTodoState([]);

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    yield LoadingTodoState(event.list);

    final prevList = List<TODOGroupModel>.from(event.list);

    if (event is LoadLocalTodoInitial) {
      try {
        final todoOrFailure = await _getLocalTodo(NoParams());

        yield await todoOrFailure.fold((failure) async {
          final setTodoOrFailure = await _setLocalTODO([]);

          return setTodoOrFailure.fold((failure) {
            return FailureTodoStateInitial(failure.error, []);
          }, (success) {
            return TodoUpdated([]);
          });
        }, (todos) {
          return TodoUpdated(todos);
        });
      } catch (e) {
        final setTodoOrFailure = await _setLocalTODO([]);

        yield setTodoOrFailure.fold((failure) {
          return FailureTodoState(failure.error, []);
        }, (success) {
          return TodoUpdated([]);
        });
      }
    }

    if (event is LoadRemoteTodoInitial) {
      final loadTodo = await _getRemoteTODO(event.uid);

      yield loadTodo.fold((failure) {
        return FailureTodoStateInitial(failure.error, prevList);
      }, (todos) {
        return TodoUpdated(todos);
      });
    }

    if (event is SetRemoteTodoInitial) {
      final setTodoOrFailure =
          await _updateRemoteTODO(TODORemoteParams(event.list, event.uid));

      yield setTodoOrFailure.fold((failure) {
        return FailureTodoState(failure.error, prevList);
      }, (success) {
        return TodoUpdated(event.list);
      });
    }

    if (event is ReorderListLocal) {
      if (event.oldIndex == (event.newIndex - 1)) {
        yield TodoUpdated(event.list);
      } else {
        final newList = event.list;

        final newIndex =
            event.newIndex > 1 ? event.newIndex - 1 : event.newIndex;

        final oldItem = newList[event.oldIndex];

        newList[event.oldIndex] = newList[newIndex];

        newList[newIndex] = oldItem;

        final saveOrFailure = await _setLocalTODO(newList);

        yield saveOrFailure.fold((failure) {
          return FailureTodoState(failure.error, prevList);
        }, (success) {
          return TodoUpdated(newList);
        });
      }
    }

    if (event is ReorderListRemote) {
      if (event.oldIndex == (event.newIndex - 1)) {
        yield TodoUpdated(event.list);
      } else {
        final newList = event.list;

        final newIndex =
            event.newIndex > 1 ? event.newIndex - 1 : event.newIndex;

        final oldItem = newList[event.oldIndex];

        newList[event.oldIndex] = newList[newIndex];

        newList[newIndex] = oldItem;

        final saveOrFailure =
            await _updateRemoteTODO(TODORemoteParams(newList, event.uid));

        yield saveOrFailure.fold((failure) {
          return FailureTodoState(failure.error, prevList);
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
              event.uniqueID,
            ),
          );

        final setTodoOrFailure = await _setLocalTODO(newList);

        yield setTodoOrFailure.fold(
          (failure) {
            return FailureTodoState(failure.error, prevList);
          },
          (success) {
            return TodoUpdated(newList);
          },
        );
      } else {
        yield FailureTodoState('This group already exist!', prevList);
      }
    }

    if (event is AddTodoGroupRemote) {
      bool isExist = false;

      for (int i = 0; i < event.prevList.length; i++) {
        if (event.prevList[i].groupName == event.title) {
          isExist = true;

          break;
        }
      }

      if (!isExist) {
        final newList = List<TODOGroupModel>.from(event.prevList);

        newList.add(
          TODOGroupModel(
            event.title,
            [],
            event.uniqueID,
          ),
        );

        final setTodoOrFailure =
            await _updateRemoteTODO(TODORemoteParams(newList, event.uid));
        yield await setTodoOrFailure.fold(
          (failure) async {
            return FailureTodoState(failure.error, prevList);
          },
          (success) async {
            return TodoUpdated(newList);
          },
        );
      } else {
        yield FailureTodoState('This group already exist!', prevList);
      }
    }

    if (event is TodoFailure) {
      yield FailureTodoState(event.error, prevList);
    }

    if (event is DeleteTodoGroupLocal) {
      List<TODOGroupModel> list;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupName) {
          list = event.list..removeAt(i);
        }
      }

      bool isError = false;

      for (int i = 0; i < event.ids.length; i++) {
        final deleteOrSuccess = await _cancelNotificationLocal(event.ids[i]);

        deleteOrSuccess.fold((failure) {
          isError = true;
        }, (success) {});

        if (isError) break;
      }

      final setOrSuccess = await _setLocalTODO(list);

      yield await setOrSuccess.fold((failure) {
        return FailureTodoState('Something went wrong! Try again!', prevList);
      }, (success) async {
        if (!isError) {
          return TodoUpdated(list);
        } else {
          return FailureTodoState('Something went wrong! Try again!', prevList);
        }
      });
    }

    if (event is DeleteTodoGroupRemote) {
      List<TODOGroupModel> list;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupName) {
          list = event.list..removeAt(i);
        }
      }

      bool isError = false;

      for (int i = 0; i < event.ids.length; i++) {
        final deleteOrSuccess = await _cancelNotificationLocal(event.ids[i]);

        deleteOrSuccess.fold((failure) {
          isError = true;
        }, (success) {});

        if (isError) break;
      }

      final setOrSuccess =
          await _updateRemoteTODO(TODORemoteParams(list, event.uid));

      yield await setOrSuccess.fold((failure) {
        return FailureTodoState('Something went wrong! Try again!', prevList);
      }, (success) async {
        if (!isError) {
          return TodoUpdated(list);
        } else {
          return FailureTodoState('Something went wrong! Try again!', prevList);
        }
      });
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
            : null,
        isComplete: false,
      );

      bool isExist = false;

      final List<TODOGroupModel> list = event.list;

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
                'This todo already exist in that group!', prevList);

            break;
          }
        }

        if (!isExist) {
          final setOrSuccess = await _setLocalTODO(list);

          yield await setOrSuccess.fold(
            (failure) {
              return FailureTodoState(failure.error, prevList);
            },
            (success) async {
              if (newTodo.date != null) {
                final notificationOrSuccess = await _setNotificationLocal(
                    NotificationModel(newTodo, event.id));

                return notificationOrSuccess.fold((failure) {
                  return FailureTodoState(failure.error, prevList);
                }, (success) {
                  return TodoUpdated(list);
                });
              } else {
                return TodoUpdated(list);
              }
            },
          );
        }
      }
    }

    if (event is AddTodoToGroupRemote) {
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
            : null,
        isComplete: false,
      );

      bool isExist = false;

      final List<TODOGroupModel> list = event.list;

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
                'This todo already exist in that group!', prevList);

            break;
          }
        }

        if (!isExist) {
          final setOrSuccess =
              await _updateRemoteTODO(TODORemoteParams(list, event.uid));

          yield await setOrSuccess.fold(
            (failure) {
              return FailureTodoState(failure.error, prevList);
            },
            (success) async {
              if (newTodo.date != null) {
                final notificationOrSuccess = await _setNotificationLocal(
                    NotificationModel(newTodo, event.id));

                return notificationOrSuccess.fold((failure) {
                  return FailureTodoState(failure.error, prevList);
                }, (success) {
                  return TodoUpdated(list);
                });
              } else {
                return TodoUpdated(list);
              }
            },
          );
        }
      }
    }

    if (event is DeleteAllTodoLocal) {
      if (!event.areYouSure) {
        yield AreYouSureForDeletingAllTodo(prevList);
      } else {
        final deleteOrSuccess = await _setLocalTODO([]);

        final delete = await _cancelAllNotificationsLocal(NoParams());

        yield deleteOrSuccess.fold((failure) {
          return FailureTodoState(failure.error, prevList);
        }, (success) {
          return delete.fold((failure) {
            return FailureTodoState(failure.error, prevList);
          }, (success) {
            return TodoUpdated([]);
          });
        });
      }
    }

    if (event is DeleteAllTodoRemote) {
      if (!event.areYouSure) {
        yield AreYouSureForDeletingAllTodo(prevList);
      } else {
        final deleteOrSuccess =
            await _updateRemoteTODO(TODORemoteParams([], event.uid));

        final delete = await _cancelAllNotificationsLocal(NoParams());

        yield deleteOrSuccess.fold((failure) {
          return FailureTodoState(failure.error, prevList);
        }, (success) {
          return delete.fold((failure) {
            return FailureTodoState(failure.error, prevList);
          }, (success) {
            return TodoUpdated([]);
          });
        });
      }
    }

    if (event is TodoChangeStatusLocal) {
      final List<TODOGroupModel> list = event.list;
      final newTodo = event.todo.copyWith(isComplete: !event.todo.isComplete);

      for (int j = 0; j < list.length; j++) {
        final todos = list[j];
        if (todos.groupName == event.groupTitle) {
          for (int i = 0; i < todos.todoList.length; i++) {
            if (todos.todoList[i].title == event.todo.title) {
              list[j].todoList[i] = newTodo;
              break;
            }
          }
          break;
        }
      }

      final setOrFailure = await _setLocalTODO(list);

      yield await setOrFailure.fold((failure) {
        return FailureTodoState(failure.error, prevList);
      }, (success) async {
        if (newTodo.date != null) {
          if (newTodo.isComplete == true) {
            final delete = await _cancelNotificationLocal(event.id);

            return delete.fold((failure) {
              return FailureTodoState(failure.error, prevList);
            }, (success) {
              return TodoUpdated(list);
            });
          } else {
            final setOrFailure = await _setNotificationLocal(
                NotificationModel(newTodo, event.id));

            return setOrFailure.fold((failure) {
              return FailureTodoState(failure.error, prevList);
            }, (success) {
              return TodoUpdated(list);
            });
          }
        } else {
          return TodoUpdated(list);
        }
      });
    }

    if (event is TodoChangeStatusRemote) {
      final List<TODOGroupModel> list = event.list;
      final newTodo = event.todo.copyWith(isComplete: !event.todo.isComplete);

      for (int j = 0; j < list.length; j++) {
        final todos = list[j];
        if (todos.groupName == event.groupTitle) {
          for (int i = 0; i < todos.todoList.length; i++) {
            if (todos.todoList[i].title == event.todo.title) {
              list[j].todoList[i] = newTodo;
              break;
            }
          }
          break;
        }
      }

      final setOrFailure =
          await _updateRemoteTODO(TODORemoteParams(list, event.uid));

      yield await setOrFailure.fold((failure) {
        return FailureTodoState(failure.error, prevList);
      }, (success) async {
        if (newTodo.date != null) {
          if (newTodo.isComplete == true) {
            final delete = await _cancelNotificationLocal(event.id);

            return delete.fold((failure) {
              return FailureTodoState(failure.error, prevList);
            }, (success) {
              return TodoUpdated(list);
            });
          } else {
            final setOrFailure = await _setNotificationLocal(
                NotificationModel(newTodo, event.id));

            return setOrFailure.fold((failure) {
              return FailureTodoState(failure.error, prevList);
            }, (success) {
              return TodoUpdated(list);
            });
          }
        } else {
          return TodoUpdated(list);
        }
      });
    }

    if (event is DeleteTodoLocal) {
      final list = event.list;

      bool isDateExist = false;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupTitle) {
          for (int j = 0; j < event.list[i].todoList.length; j++) {
            if (event.list[i].todoList[j].title == event.todoTitle) {
              list[i].todoList.removeAt(j);
              if (list[i].todoList[j].date != null) isDateExist = true;
              break;
            }
          }
          break;
        }
      }

      final setOrSuccess = await _setLocalTODO(list);

      Either<Failure, void> delete;

      if (isDateExist) delete = await _cancelNotificationLocal(event.id);

      yield setOrSuccess.fold(
          (failure) => FailureTodoState(failure.error, prevList), (success) {
        if (isDateExist) {
          return delete.fold((failure) {
            return FailureTodoState(failure.error, prevList);
          }, (success) {
            return TodoUpdated(list);
          });
        } else {
          return TodoUpdated(list);
        }
      });
    }

    if (event is DeleteTodoRemote) {
      final list = event.list;

      bool isDateExist = false;

      for (int i = 0; i < event.list.length; i++) {
        if (event.list[i].groupName == event.groupTitle) {
          for (int j = 0; j < event.list[i].todoList.length; j++) {
            if (event.list[i].todoList[j].title == event.todoTitle) {
              if (list[i].todoList[j].date != null) isDateExist = true;
              list[i].todoList.removeAt(j);
              break;
            }
          }
          break;
        }
      }

      final setOrSuccess =
          await _updateRemoteTODO(TODORemoteParams(list, event.uid));

      Either<Failure, void> delete;

      if (isDateExist) delete = await _cancelNotificationLocal(event.id);

      yield setOrSuccess.fold(
          (failure) => FailureTodoState(failure.error, prevList), (success) {
        if (isDateExist) {
          return delete.fold((failure) {
            return FailureTodoState(failure.error, prevList);
          }, (success) {
            return TodoUpdated(list);
          });
        } else {
          return TodoUpdated(list);
        }
      });
    }
  }
}
