import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/notifications/data/models/notifications_model.dart';
import 'package:todoapp/features/notifications/domain/usecases/set_notification.dart';
import 'package:todoapp/features/todo/data/model/todo_model.dart';

import '../../../settings/domain/usecases/set_settings_local_test.dart';
import 'cancel_all_notifications_test.dart';

void main() {
  MockNotificationsRepository mockNotificationsRepository;
  SetNotificationLocal usecase;

  setUp(() {
    mockNotificationsRepository = MockNotificationsRepository();
    usecase = SetNotificationLocal(mockNotificationsRepository);
  });

  const int tId = 123454;

  const TODOModel tTodo = TODOModel(
    body: 'yuuuh',
    isComplete: false,
    title: 'myaah',
  );

  const NotificationModel tNotification = NotificationModel(tTodo, tId);

  test('Should cancel all notifications using FlutterLocalNotifications',
      () async {
    when(mockNotificationsRepository.setNotification(tNotification)).thenAnswer(
      (_) async => Right(
        doSomething(),
      ),
    );

    final result = await usecase(tNotification);

    expect(result, Right(doSomething()));

    verify(mockNotificationsRepository.setNotification(tNotification));

    verifyNoMoreInteractions(mockNotificationsRepository);
  });
}
