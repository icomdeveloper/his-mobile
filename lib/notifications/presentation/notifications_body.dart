// import 'package:flutter/material.dart';
// import 'package:his/core/utils/app_text_styles.dart';
// import 'package:his/notifications/model/notifications_response.dart';
// import 'package:his/notifications/presentation/notification_widget.dart';
// import 'package:provider/provider.dart';

// import '../../../../../core/helpers/notifications_count_provider.dart';

// class NotificationsBody extends StatefulWidget {
//   const NotificationsBody({
//     super.key,
//     required this.notifications,
//   });

//   final List<NotificationItem> notifications;
//   @override
//   State<NotificationsBody> createState() => _NotificationsBodyState();
// }

// class _NotificationsBodyState extends State<NotificationsBody> {
//   @override
//   initState() {
//     super.initState();
//     widget.notifications.map((item) => checkDates(item)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//         onPopInvokedWithResult: (didPop, result) {
//           if (didPop) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               final notificationsProvider =
//                   Provider.of<NotificationsCountProvider>(context,
//                       listen: false);
//               notificationsProvider
//                   .markAsRead(notificationsProvider.unreadCount);
//             });
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 24,
//           ),
//           child: CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                   child: todayList.isEmpty
//                       ? const SizedBox.shrink()
//                       : const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 12),
//                             Text(
//                               'Today',
//                               style: Styles.semiBoldPoppins20,
//                             ),
//                             SizedBox(height: 12),
//                           ],
//                         )),
//               SliverList.separated(
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 12),
//                   itemCount: todayList.length,
//                   itemBuilder: (context, index) {
//                     return NotificationWidget(
//                       item: todayList[index],
//                     );
//                   }),
//               SliverToBoxAdapter(
//                   child: yesterdayList.isEmpty
//                       ? const SizedBox.shrink()
//                       : const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 12),
//                             Text(
//                               'Yesterday',
//                               style: Styles.semiBoldPoppins20,
//                             ),
//                             SizedBox(height: 12),
//                           ],
//                         )),
//               SliverList.separated(
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 12),
//                   itemCount: yesterdayList.length,
//                   itemBuilder: (context, index) {
//                     return NotificationWidget(item: yesterdayList[index]);
//                   }),
//               SliverToBoxAdapter(
//                   child: pastList.isEmpty
//                       ? const SizedBox.shrink()
//                       : const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 12),
//                             Text(
//                               'Past',
//                               style: Styles.semiBoldPoppins20,
//                             ),
//                             SizedBox(height: 12),
//                           ],
//                         )),
//               SliverList.separated(
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 12),
//                   itemCount: pastList.length,
//                   itemBuilder: (context, index) {
//                     return NotificationWidget(item: pastList[index]);
//                   }),
//             ],
//           ),
//         ));
//   }

//   checkDates(NotificationItem notification) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));

//     if (notification.createdAt.day == today.day &&
//         notification.createdAt.month == today.month &&
//         notification.createdAt.year == today.year) {
//       todayList.add(notification);
//     } else if (notification.createdAt.day == yesterday.day &&
//         notification.createdAt.month == yesterday.month &&
//         notification.createdAt.year == yesterday.year) {
//       yesterdayList.add(notification);
//     } else {
//       pastList.add(notification);
//     }
//   }
// }

// List<NotificationItem> todayList = [];
// List<NotificationItem> yesterdayList = [];
// List<NotificationItem> pastList = [];
