import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/notifications/data/datasource/notifications_datasource.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository.dart';

import '../models/notifications_model.dart';

class LocalNotificationsRepositoryImpl extends NotificationsRepository {
  final LocalNotificationsDatasourceImpl _datasourceImpl;

  LocalNotificationsRepositoryImpl(this._datasourceImpl);

  Future<Either<Failure, T>> _handleCalls<T>(Future<T> Function() call) async {
    try {
      final success = await call();

      return Right(success);
    } catch (e) {
      return Left(Failure(error: 'Something went wrong with notifications!'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelNotification(int id) async {
    return _handleCalls<void>(() => _datasourceImpl.cancelNotification(id));
  }

  @override
  Future<Either<Failure, void>> setNotification(
      NotificationModel notification) async {
    return _handleCalls<void>(
        () => _datasourceImpl.setNotification(notification));
  }

  @override
  Future<Either<Failure, void>> cancelAllNotifications() async {
    return _handleCalls<void>(() => _datasourceImpl.cancelAllNotifications());
  }
}
