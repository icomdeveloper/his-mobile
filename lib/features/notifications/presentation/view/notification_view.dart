import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/utils/app_text_styles.dart';
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
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'No notifications yet',
                      style: Styles.semiBoldPoppins16,
                    ),
                  ],
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
                context
                    .read<NotificationCubit>()
                    .getNotifications(context: context);
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
