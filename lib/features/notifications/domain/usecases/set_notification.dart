import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository.dart';

import '../../data/models/notifications_model.dart';

class SetNotificationLocal extends UseCase<void, NotificationModel> {
  final NotificationsRepository notificationsRepositoryLocal;

  SetNotificationLocal(this.notificationsRepositoryLocal);
  @override
  Future<Either<Failure, void>> call(NotificationModel params) async {
    return notificationsRepositoryLocal.setNotification(params);
  }
}
