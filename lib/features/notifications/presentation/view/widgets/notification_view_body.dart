import 'package:flutter/material.dart';
import 'package:his/core/models/notifcation_model/notifcation_model.dart';
import 'package:his/features/notifications/presentation/view/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, required this.notifications});
  final List<NotifcationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: notifications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return NotificationItem(item: notifications[index]);
      },
    );
  }
}
