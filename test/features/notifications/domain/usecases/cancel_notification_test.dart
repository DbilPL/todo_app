import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/notifications/domain/usecases/cancel_notification.dart';

import '../../../settings/domain/usecases/set_settings_local_test.dart';
import 'cancel_all_notifications_test.dart';

void main() {
  MockNotificationsRepository mockNotificationsRepository;
  CancelNotificationLocal usecase;

  setUp(() {
    mockNotificationsRepository = MockNotificationsRepository();
    usecase = CancelNotificationLocal(mockNotificationsRepository);
  });

  final int tId = 123454;

  test('Should cancel all notifications using FlutterLocalNotifications',
      () async {
    when(mockNotificationsRepository.cancelNotification(tId)).thenAnswer(
      (_) async => Right(
        doSomething(),
      ),
    );

    final result = await usecase(tId);

    expect(result, Right(doSomething()));

    verify(mockNotificationsRepository.cancelNotification(tId));

    verifyNoMoreInteractions(mockNotificationsRepository);
  });
}
