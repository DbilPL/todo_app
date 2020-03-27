import 'package:dartz/dartz.dart';
import 'package:todoapp/core/errors/failure.dart';
import 'package:todoapp/core/usecases/usecase.dart';
import 'package:todoapp/features/notifications/domain/repositories/notifications_repository_local.dart';
import 'package:todoapp/features/settings/domain/usecases/get_current_settings_local.dart';

class CancelAllNotificationsLocal extends UseCase<void, NoParams> {
  final NotificationsRepositoryLocal notificationsRepositoryLocal;

  CancelAllNotificationsLocal(this.notificationsRepositoryLocal);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await notificationsRepositoryLocal.cancelAllNotifications();
  }
}
