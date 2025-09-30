import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/notifications/bloc/notifications_state.dart';
import 'package:his/notifications/model/notifications_response.dart';
import 'package:his/notifications/services/notifications_services.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService service;

  NotificationCubit(this.service) : super(NotificationInitial());

  String? nextPageUrl;
  bool hasMore = true;
  List<NotificationItem> notifications = [];
  Future<void> loadNotifications({
    bool refresh = false,
  }) async {
    if (refresh) {
      notifications.clear();
      nextPageUrl = null;
      hasMore = true;
    }

    if (!hasMore) return;

    emit(NotificationLoading(notifications));

    try {
      final response =
          await service.getNotifications(nextPageUrl: nextPageUrl, page: 1);
      notifications.addAll(response.data!.notifications!);

      nextPageUrl = response.data!.nextPageUrl;
      hasMore = nextPageUrl != null;

      emit(NotificationLoaded(List.from(notifications), hasMore: hasMore));
    } catch (e) {
      emit(NotificationError(e.toString(), notifications));
    }
  }

  Future<void> loadUnreadNotifications() async {
    try {
      final response = await service.getUnreadNotifications();
      emit(UnReadNotificationsSuccess(data: response.data!));
    } catch (e) {
      emit(UnReadNotificationsFailure());
    }
  }

  Future<void> markAsRead(
    int id,
  ) async {
    try {
      await service.markAsRead(id);
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(seen: 1);
        emit(NotificationLoaded(List.from(notifications), hasMore: hasMore));

        // ✅ update count locally
        // unreadCubit?.decrease();
      }
    } catch (_) {}
  }
}
