import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/notifications/domain/entities/notification.dart';
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

  final int tId = 123454;

  final TODOModel tTodo = TODOModel(
    date: null,
    body: 'yuuuh',
    isComplete: false,
    title: 'myaah',
  );

  final Notification tNotification = Notification(tTodo, tId);

  test('Should cancel all notifications using FlutterLocalNotifications',
      () async {
    when(mockNotificationsRepository.setNotification(tNotification)).thenAnswer(
      (_) async => Right(
        doSomething(),
      ),
    );

    final result =
        await mockNotificationsRepository.setNotification(tNotification);

    expect(result, Right(doSomething()));

    verify(mockNotificationsRepository.setNotification(tNotification));

    verifyNoMoreInteractions(mockNotificationsRepository);
  });
}
