import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/model/media_model.dart';

import 'package:his/features/profile/presentation/view/widgets/approved_video_sliver_list.dart';

class PublishedTabBar extends StatelessWidget {
  const PublishedTabBar({super.key, required this.mediaList});
  final List<MediaModel> mediaList;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        if (mediaList.isEmpty)
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'You have no videos yet',
                style: Styles.semiBoldPoppins14,
              ),
            ),
          ),
        ApprovedVideosSliverList(
          mediaList: mediaList,
        )
      ],
    );
  }
}
