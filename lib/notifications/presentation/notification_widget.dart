import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/format_duration.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/video_view.dart';
import 'package:his/notifications/bloc/notifications_bloc.dart';
import 'package:his/notifications/model/notifications_response.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    super.key,
    required this.item,
  });

  final NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.seen == 0 ? AppColors.lightGrey : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (item.seen == 0) {
            context.read<NotificationCubit>().markAsRead(
                  item.id!,
                );
          }

          if (item.mediaId != null) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => VideoView(
                  mediaModel: MediaModel(
                      id: item.mediaId ?? 0, status: extractStatus()),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            );
          }
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(item.sender?.profileImage ?? avatarImage),
              radius: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title ?? '', style: Styles.semiBoldPoppins16),
                  const SizedBox(height: 4),
                  Text(item.sender?.name ?? '',
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey)),
                  const SizedBox(height: 4),
                  Text(item.body ?? '', style: Styles.regularPoppins14),
                  const SizedBox(height: 8),
                  Text(formatDate(item.createdAt ?? DateTime.now()),
                      style: Styles.regularPoppins12.copyWith(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
            ),
            if (item.seen == 0)
              const Icon(
                Icons.circle,
                color: AppColors.primaryColor,
                size: 12,
              )
          ],
        ),
      ),
    );
  }

  extractStatus() {
    if (item.route != null) {
      // extract the video status from the route
      // content/videos/86/pending
      final status = item.route!.split('/')[3];
      return status;
    }
    return null;
  }
}
