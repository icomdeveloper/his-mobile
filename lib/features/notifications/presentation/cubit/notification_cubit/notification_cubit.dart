import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/core/models/notifcation_model/notifcation_model.dart';
import 'package:his/core/repo/notifications_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());
  final NotificationsRepo notificationRepo;

  Timer? _timer;

  Future<void> getNotifications({required BuildContext context}) async {
    final result = await notificationRepo.getNotifications(context: context);
    if (isClosed) return;
    result.fold(
      (failure) => emit(NotificationFailure(message: failure.errMesage)),
      (notifications) =>
          emit(NotificationSuccess(notificationList: notifications)),
    );
  }

  /// Start polling every 15 seconds
  void startPolling({required BuildContext context}) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      getNotifications(context: context);
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // cleanup
    return super.close();
  }
}
