import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/todo/data/model/todo_list_model.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';
import 'package:todoapp/features/todo/data/repository/todo_remote_repository_impl.dart';
import 'package:todoapp/features/todo/domain/usecases/update_remote_todo.dart';

import 'get_remote_todo_test.dart';

void main() {
  UpdateRemoteTODO usecase;
  MockRemoteTodoRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockRemoteTodoRepository();
    usecase = UpdateRemoteTODO(mockSettingsRepository);
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

  final TODORemoteParams params = TODORemoteParams(tTodo, uid);

  test('Should get todo from Firebase using repository', () async {
    when(mockSettingsRepository.updateTODO(params))
        .thenAnswer((_) async => Right(tTodo));

    final result = await usecase(params);

    expect(result, Right(tTodo));
    verify(mockSettingsRepository.updateTODO(params));
    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
