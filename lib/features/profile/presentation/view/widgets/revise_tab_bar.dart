import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_video_widget.dart';

class ReviseTabBar extends StatelessWidget {
  const ReviseTabBar({super.key, required this.mediaList});
  final List<MediaModel> mediaList;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        if (mediaList.isEmpty)
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'You have no Revise videos',
                style: Styles.semiBoldPoppins14,
              ),
            ),
          ),
        PendingVideosSliverList(
          mediaList: mediaList,
          isIconAppear: false,
        )
      ],
    );
  }
}
