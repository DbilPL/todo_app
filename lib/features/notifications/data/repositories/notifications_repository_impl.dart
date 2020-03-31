import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/notifications/data/datasource/notifications_datasource.dart';
import 'package:todoapp/features/notifications/domain/entities/notification.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository.dart';

class LocalNotificationsRepositoryImpl extends NotificationsRepository {
  final LocalNotificationsDatasourceImpl datasourceImpl;

  LocalNotificationsRepositoryImpl(this.datasourceImpl);

  @override
  Future<Either<Failure, void>> cancelNotification(int id) async {
    try {
      final success = await datasourceImpl.cancelNotification(id);

      return Right(success);
    } catch (e) {
      return Left(Failure(error: 'Something went wrong with notifications!'));
    }
  }

  @override
  Future<Either<Failure, void>> setNotification(
      Notification notification) async {
    try {
      final success = await datasourceImpl.setNotification(notification);

      return Right(success);
    } catch (e) {
      return Left(Failure(error: 'Something went wrong with notifications!'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAllNotifications() async {
    try {
      final success = await datasourceImpl.cancelAllNotifications();

      return Right(success);
    } catch (e) {
      return Left(Failure(error: 'Something went wrong with notifications!'));
    }
  }
}
