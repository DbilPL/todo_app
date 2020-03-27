import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository_local.dart';

class CancelNotificationLocal extends UseCase<void, int> {
  final NotificationsRepositoryLocal notificationsRepositoryLocal;

  CancelNotificationLocal(this.notificationsRepositoryLocal);
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await notificationsRepositoryLocal.cancelNotification(params);
  }
}
