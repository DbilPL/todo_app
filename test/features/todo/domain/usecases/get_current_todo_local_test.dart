import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/repositories/local_todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/get_local_todo.dart';

class MockLocalTodoRepository extends Mock implements LocalTODORepository {}

void main() {
  GetLocalTodo usecase;
  MockLocalTodoRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockLocalTodoRepository();
    usecase = GetLocalTodo(mockSettingsRepository);
  });

  final tTodo = [
    TODOGroupModel(
        'wow',
        [
          TODOModel(isComplete: false, date: null, title: 'yay', body: 'yay'),
        ],
        1923847),
  ];
  test('Should get todo locally on device using repository', () async {
    when(mockSettingsRepository.getTODO()).thenAnswer((_) => Right(tTodo));

    final result = await usecase(NoParams());

    expect(result, Right(tTodo));
    verify(mockSettingsRepository.getTODO());
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
