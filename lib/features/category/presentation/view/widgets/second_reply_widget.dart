import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/calculate_time_ago.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/helpers/images_format.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/home/data/models/comments_model/reply_model.dart';
import '../../../../../core/utils/app_colors.dart';

class SecondReplyWidget extends StatefulWidget {
  const SecondReplyWidget({
    super.key,
    required this.reply,
    required this.index,
    this.isSecondReply = false,
  });

  final ReplyModel reply;
  final int index;
  final bool isSecondReply;

  @override
  State<SecondReplyWidget> createState() => _SecondReplyWidgetState();
}

class _SecondReplyWidgetState extends State<SecondReplyWidget> {
  late UserInformation userInformation;
  @override
  initState() {
    super.initState();
    userInformation = widget.reply.user ?? dummyUserInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          minTileHeight: 62.h,
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          leading: InkWell(
            onTap: () {
              if (widget.reply.user?.profileImage != null) {
                showDialog(
                  context: context,
                  builder: (_) => Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 220.h),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: formatImageUrl(
                            userInformation.profileImage ?? avatarImage),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: CachedNetworkImageProvider(formatImageUrl(
                  widget.reply.user?.profileImage ?? avatarImage)),
              radius: 12.r,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.reply.user?.name ?? '',
                style: Styles.semiBoldPoppins12,
              ),
              Text(getRelativeTime(widget.reply.createdAt ?? DateTime.now()),
                  style: Styles.regularPoppins12.copyWith(
                    fontSize: 10,
                    color: AppColors.grey,
                  )),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.reply.content ?? '',
                  style: Styles.regularPoppins12.copyWith(
                    color: AppColors.grey,
                  )),
              if (widget.reply.secondReplies != null &&
                  widget.reply.secondReplies!.isNotEmpty)
                SizedBox(
                  height: 12.h,
                ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
