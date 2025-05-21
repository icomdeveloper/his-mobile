import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/view/widgets/featured_video_card_widget.dart';

class FeaturedVideosItem extends StatelessWidget {
  const FeaturedVideosItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Column(children: [
        const FeaturedVideoCardWidget(),
        SizedBox(height: 8.h),
        const Text(
          'Lorem ipsum dolor sit amet consectetur. Odio commodo consectetur magna .',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Styles.semiBoldPoppins14,
        ),
        SizedBox(height: 4.h),
        Text(
          'Lorem ipsum dolor sit amet consectetur. Ut elit tempus faucibus vitae sit. Eleifend ac euismod placerat a eu. Gravida lacus commodo neque ut.',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Styles.regularRoboto12.copyWith(color: AppColors.grey),
        ),
      ]),
    );
  }
}
