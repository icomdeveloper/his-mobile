import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/text_container_widget.dart';

class RecentlyBookMarksWidget extends StatelessWidget {
  const RecentlyBookMarksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xffEDEDED), width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 97.w,
            child: AspectRatio(
              aspectRatio: 97.w / 102.h,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Image.asset(Assets.assetsImagesDoctestimage,
                    fit: BoxFit.fill),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width - (97.w + 12 + 48 + 50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TextContainerWidget(
                      text: 'Video',
                    ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Text(
                      '15:30 Mins ',
                      style: Styles.semiBoldRoboto10
                          .copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
                const Text(
                  'Lorem ipsum dolor sit amet consectetur.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Styles.semiBoldRoboto12,
                ),
                Text(
                  'Bookmarked May 12 , 2025',
                  style: Styles.regularRoboto10.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            icon: SvgPicture.asset(Assets.assetsImagesMoreVert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
