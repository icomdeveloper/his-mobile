import 'package:bloc/bloc.dart';
import 'package:his/core/models/notifcation_model/notifcation_model.dart';
import 'package:his/core/repo/notifications_repo.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());
  final NotificationsRepo notificationRepo;

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    final result = await notificationRepo.getNotifications();
    if (isClosed) return;
    result.fold(
        (failure) => emit(NotificationFailure(message: failure.errMesage)),
        (notifications) =>
            emit(NotificationSuccess(notificationList: notifications)));
  }
}
