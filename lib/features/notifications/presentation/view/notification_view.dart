import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/notifications/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:his/features/notifications/presentation/view/widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'Notifications', centerTitle: true),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationSuccess) {
            if (state.notificationList.isEmpty) {
              return Center(
                child: CustomErrorWidget(
                  errorMessage: 'No notifications found',
                  onTap: () {
                    context.read<NotificationCubit>().getNotifications();
                  },
                ),
              );
            }
            return NotificationScreen(
              notifications: state.notificationList,
            );
          } else if (state is NotificationFailure) {
            return Center(
                child: CustomErrorWidget(
              errorMessage: state.message,
              onTap: () {
                context.read<NotificationCubit>().getNotifications();
              },
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
