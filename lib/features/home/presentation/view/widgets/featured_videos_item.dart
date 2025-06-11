import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/view/widgets/featured_video_card_widget.dart';
import 'package:his/features/home/presentation/view/widgets/likes_and_comment_widget.dart';

class FeaturedVideosItem extends StatelessWidget {
  const FeaturedVideosItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: Column(children: [
        const FeaturedVideoCardWidget(),
        SizedBox(height: 8.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Text(
                'Lorem ipsum dolor sit amet consecte. Odio commodo consectetur magna .',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Styles.semiBoldPoppins14,
              ),
              SizedBox(height: 4.h),
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Ut elit tempus faucibus vitae sit. Eleifend ac euismod placerat a eu. Gravida lacus commodo neque ut.',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Styles.regularRoboto12,
              ),
              const Divider(
                color: AppColors.lightGrey,
              ),
              const SizedBox(height: 8),
              const LikesAndCommentsWidget(),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        )
      ]),
    );
  }
}
