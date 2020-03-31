import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:todoapp/features/notifications/domain/usecases/cancel_all_notifications.dart';

import '../../../settings/domain/usecases/set_settings_local_test.dart';

class MockNotificationsRepository extends Mock
    implements NotificationsRepository {}

void main() {
  MockNotificationsRepository mockNotificationsRepository;
  CancelAllNotificationsLocal usecase;

  setUp(() {
    mockNotificationsRepository = MockNotificationsRepository();
    usecase = CancelAllNotificationsLocal(mockNotificationsRepository);
  });

  test('Should cancel all notifications using FlutterLocalNotifications',
      () async {
    when(mockNotificationsRepository.cancelAllNotifications()).thenAnswer(
      (_) async => Right(
        doSomething(),
      ),
    );

    final result = await mockNotificationsRepository.cancelAllNotifications();

    expect(result, Right(doSomething()));

    verify(mockNotificationsRepository.cancelAllNotifications());

    verifyNoMoreInteractions(mockNotificationsRepository);
  });
}
