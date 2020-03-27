import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/features/notifications/domain/entities/notification.dart';

abstract class NotificationsRepositoryLocal {
  Future<Either<Failure, void>> setNotification(Notification notification);

  Future<Either<Failure, void>> cancelNotification(int id);

  Future<Either<Failure, void>> cancelAllNotifications();
}
