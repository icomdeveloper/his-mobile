import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/notifications/bloc/notifications_bloc.dart';
import 'package:his/notifications/bloc/notifications_state.dart';
import 'package:his/notifications/presentation/notification_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  static const String routeName = '/notifications';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'Notifications', centerTitle: true,
          onTapBack: () {
        context.read<NotificationCubit>().loadUnreadNotifications();
        Navigator.pop(context);
      }),
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            context.read<NotificationCubit>().loadUnreadNotifications();
          }
        },
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state is NotificationInitial ||
                state is UnReadNotificationsSuccess ||
                state is UnReadNotificationsFailure) {
              context.read<NotificationCubit>().loadNotifications();
              return const Center(child: CircularProgressIndicator());
            }

            if (state is NotificationLoading && state.oldData.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final notifications = state is NotificationLoaded
                ? state.data
                : (state is NotificationLoading
                    ? state.oldData
                    : (state as NotificationError).oldData);

            return ListView.builder(
              itemCount: notifications.length +
                  (state is NotificationLoaded && state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == notifications.length) {
                  context.read<NotificationCubit>().loadNotifications();
                  return const Center(child: CircularProgressIndicator());
                }
                final n = notifications[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: NotificationWidget(
                    item: n,
                  ),
                );
                // return ListTile(
                //   title: Text(n.title),
                //   subtitle: Text(n.body),
                //   trailing: n.seen == 0
                //       ? IconButton(
                //           icon: const Icon(Icons.mark_email_read),
                //           onPressed: () => context
                //               .read<NotificationCubit>()
                //               .markAsRead(n.id,
                //                   unreadCubit: context.read<UnreadCountCubit>()),
                //         )
                //       : null,
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
