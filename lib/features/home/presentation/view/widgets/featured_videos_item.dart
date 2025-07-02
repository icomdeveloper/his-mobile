import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/widgets/featured_video_card_widget.dart';
import 'package:his/features/home/presentation/view/widgets/likes_and_comment_widget.dart';

class FeaturedVideosItem extends StatelessWidget {
  const FeaturedVideosItem({super.key, required this.mediaModel});
  final MediaModel mediaModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 48.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: Column(children: [
        FeaturedVideoCardWidget(
          mediaModel: mediaModel,
        ),
        SizedBox(height: 8.h),
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 14),
          child: Column(
            children: [
              Text(
                mediaModel.title ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Styles.semiBoldPoppins14,
              ),
              SizedBox(height: 4.h),
              Text(
                mediaModel.description ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Styles.regularPoppins12.copyWith(color: AppColors.grey),
              ),
              const Divider(
                color: AppColors.lightGrey,
              ),
              const SizedBox(height: 8),
              LikesAndCommentsWidget(
                mediaId: mediaModel.id!,
                numberOfComments: mediaModel.commentsCount ?? 0,
                numberOfLikes: mediaModel.likesCount ?? 0,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
