import 'package:flutter/material.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/bookmarks/presentation/view/widgets/article_widget.dart';
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
              onIconTap: () {
                showModalBottomSheet(
                    showDragHandle: true,
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (context) => const PendingVideoBottomSheet());
              },
              iconImage: Assets.assetsImagesInfo,
              isDescriptionAppeared: false,
            )
          : const ArticleWidget(),
      itemCount: 2,
    );
  }
}
