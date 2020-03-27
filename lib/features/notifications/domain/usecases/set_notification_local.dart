import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/notifications/domain/entities/notification.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository_local.dart';

class SetNotificationLocal extends UseCase<void, Notification> {
  final NotificationsRepositoryLocal notificationsRepositoryLocal;

  SetNotificationLocal(this.notificationsRepositoryLocal);
  @override
  Future<Either<Failure, void>> call(Notification params) async {
    return await notificationsRepositoryLocal.setNotification(params);
  }
}
