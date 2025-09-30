import 'package:his/notifications/model/notifications_response.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {
  final List<NotificationItem> oldData;
  NotificationLoading(this.oldData);
}

class NotificationLoaded extends NotificationState {
  final List<NotificationItem> data;
  final bool hasMore;
  NotificationLoaded(this.data, {required this.hasMore});
}

class UnReadNotificationsSuccess extends NotificationState {
  final NotificationData data;
  UnReadNotificationsSuccess({required this.data});
}

class UnReadNotificationsFailure extends NotificationState {
  UnReadNotificationsFailure();
}

class NotificationError extends NotificationState {
  final String message;
  final List<NotificationItem> oldData;
  NotificationError(this.message, this.oldData);
}
