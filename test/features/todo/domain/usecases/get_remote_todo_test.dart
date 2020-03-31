import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/domain/repositories/remote_todo_repository.dart';
import 'package:todoapp/features/todo/domain/usecases/get_remote_todo.dart';

class MockRemoteTodoRepository extends Mock implements RemoteTODORepository {}

void main() {
  GetRemoteTODO usecase;
  MockRemoteTodoRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockRemoteTodoRepository();
    usecase = GetRemoteTODO(mockSettingsRepository);
  });

  final tTodo = [
    TODOGroupModel(
        'wow',
        [
          TODOModel(isComplete: false, date: null, title: 'yay', body: 'yay'),
        ],
        1923847),
  ];

  final String uid = 'yaaytoken';

  test('Should get todo from Firebase using repository', () async {
    when(mockSettingsRepository.getTODO(uid))
        .thenAnswer((_) async => Right(tTodo));

    final result = await usecase(uid);

    expect(result, Right(tTodo));
    verify(mockSettingsRepository.getTODO(uid));
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
