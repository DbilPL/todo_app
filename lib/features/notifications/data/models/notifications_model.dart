import 'package:todoapp/features/todo/data/model/todo_model.dart';

import '../../domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel(TODOModel data, int id) : super(data, id);
}
