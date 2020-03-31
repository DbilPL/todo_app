import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/usecases/set_local_todo.dart';

import '../../../settings/domain/usecases/set_settings_local_test.dart';
import 'get_current_todo_local_test.dart';

void main() {
  SetLocalTODO usecase;
  MockLocalTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockLocalTodoRepository();
    usecase = SetLocalTODO(mockTodoRepository);
  });

  final tTodo = [
    TODOGroupModel(
        'wow',
        [
          TODOModel(isComplete: false, date: null, title: 'yay', body: 'yay'),
        ],
        1923847),
  ];

  test('Should set todo locally on device using repository', () async {
    when(mockTodoRepository.setTODO(tTodo))
        .thenAnswer((_) async => Right(doSomething()));

    final result = await usecase(tTodo);

    expect(result, Right(doSomething()));

    verify(mockTodoRepository.setTODO(tTodo));
    verifyNoMoreInteractions(mockTodoRepository);
  });
}
