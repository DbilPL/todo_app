import 'package:todoapp/features/todo/data/model/todo_model.dart';

import '../../domain/entities/notification.dart';

class NotificationModel extends Notification {
  final TODOModel data;

  final int id;

  NotificationModel(this.data, this.id) : super(data, id);
}
