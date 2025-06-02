import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/bookmarks/presentation/view/widgets/article_widget.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class PendingVideosArticlesWidget extends StatelessWidget {
  const PendingVideosArticlesWidget({super.key, this.isVideo = true});
  final bool isVideo;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isVideo
            ? const VideoCardWidget(
                isBookmarkAppeared: false,
                isDescriptionAppeared: false,
              )
            : const ArticleWidget(),
        const SizedBox(height: 24),
        Text(
          'Admin Rating (1-5)',
          style:
              Styles.semiBoldPoppins14.copyWith(color: const Color(0xff171712)),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.only(left: 12, top: 20, bottom: 20),
          width: double.infinity,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  width: 1,
                  color: AppColors.lightGrey,
                )),
          ),
          child: const Text('5', style: Styles.regularRoboto12),
        ),
        const SizedBox(height: 12),
        Text(
          'Removal Requests',
          style:
              Styles.semiBoldPoppins14.copyWith(color: const Color(0xff171712)),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  width: 1,
                  color: AppColors.lightGrey,
                )),
          ),
          child: const Text(
              'Lorem ipsum dolor sit amet consectetur. Dictumst sed ultrices egestas nibh ligula tristique adipiscing mi egestas. Libero tellus scelerisque posuere imperdiet vitae tortor diam. Sollicitudin quam libero mauris condimentum tristique lacinia.',
              style: Styles.regularRoboto12),
        ),
      ],
    );
  }
}
