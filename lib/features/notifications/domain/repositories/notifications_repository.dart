import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';

import '../../data/models/notifications_model.dart';

abstract class NotificationsRepository {
  /// Sets up notification
  Future<Either<Failure, void>> setNotification(NotificationModel notification);

  /// Cancels notifcication by its id
  Future<Either<Failure, void>> cancelNotification(int id);

  /// Cancels all notifcication
  Future<Either<Failure, void>> cancelAllNotifications();
}
