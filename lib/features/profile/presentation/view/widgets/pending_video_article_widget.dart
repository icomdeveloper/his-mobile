import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/home/presentation/view/widgets/article_widget.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_video_bottom_sheet.dart';

class PendingVideosArticlesWidget extends StatelessWidget {
  const PendingVideosArticlesWidget({super.key, this.isVideo = true});
  final bool isVideo;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemBuilder: (context, index) => isVideo
          ? VideoCardWidget(
              mediaModel: dummyMedia,
              onIconTap: () {
                showModalBottomSheet(
                    showDragHandle: true,
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (context) => const PendingVideoBottomSheet());
              },
              topRightIcon: SvgPicture.asset(
                Assets.assetsImagesInfo,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
              isDescriptionAppeared: false,
            )
          : ArticleWidget(
              articleModel: dummyArticle,
            ),
      itemCount: 2,
    );
  }
}
