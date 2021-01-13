import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository.dart';

class CancelNotificationLocal extends UseCase<void, int> {
  final NotificationsRepository notificationsRepositoryLocal;

  CancelNotificationLocal(this.notificationsRepositoryLocal);
  @override
  Future<Either<Failure, void>> call(int params) async {
    return notificationsRepositoryLocal.cancelNotification(params);
  }
}
