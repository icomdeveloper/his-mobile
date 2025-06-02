import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_video_article_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_list_tile.dart';

class PendingTabBar extends StatelessWidget {
  const PendingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Text(
            'Your post is pending approval',
            style: Styles.semiBoldRoboto20
                .copyWith(color: const Color(0xff171712)),
          ),
          SizedBox(height: 12.h),
          Text(
            'This group requires posts to be approved by an admin or moderator before they are visible tox other members. This helps ensure that all content aligns with the group\'s guidelines and maintains a positive environment.',
            style: Styles.regularPoppins14
                .copyWith(color: const Color(0xff171712)),
          ),
          SizedBox(height: 24.h),
          const Text(
            'What to do while you wait',
            style: Styles.semiBoldRoboto20,
          ),
          const UserDataListTile(
            title: 'Contact Admin',
            image: Assets.assetsImagesMessage,
            subTitle:
                'Check with the admin or moderator for an estimated approval time.',
            imageColor: Colors.black,
            padding: 12,
          ),
          const UserDataListTile(
            title: 'Review Post',
            image: Assets.assetsImagesPost,
            subTitle:
                'Review your post to ensure it aligns with the group\'s rules and guidelines.',
            imageColor: Colors.black,
            padding: 12,
          ),
          const UserDataListTile(
            title: 'Edit Post',
            image: Assets.assetsImagesPencil,
            subTitle:
                'If necessary, consider editing your post to better fit the group\'s standards.',
            imageColor: Colors.black,
            padding: 12,
          ),
          const UserDataListTile(
            title: 'Contact Admin',
            image: Assets.assetsImagesEmail,
            subTitle:
                'If you have questions or concerns, reach out to the admin or moderator directly.',
            imageColor: Colors.black,
            padding: 12,
          ),
          const UserDataListTile(
            title: 'Wait for Approval',
            image: Assets.assetsImagesTime,
            subTitle:
                'In most cases, you just need to wait for the admin or moderator to review and approve your post.',
            imageColor: Colors.black,
            padding: 12,
          ),
          SizedBox(height: 24.h),
          const Text('Pending Content', style: Styles.semiBoldRoboto20),
          SizedBox(height: 12.h),
          const PendingVideosArticlesWidget(),
          const Divider(
            color: AppColors.lightGrey,
            height: 24,
          ),
          const PendingVideosArticlesWidget(isVideo: false),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
