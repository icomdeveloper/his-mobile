import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_video_article_widget.dart';

class PendingTabBar extends StatelessWidget {
  const PendingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        const PendingVideosArticlesWidget(),
        const SliverToBoxAdapter(
          child: Divider(
            color: AppColors.lightGrey,
            height: 32,
          ),
        ),
        // const PendingVideosArticlesWidget(isVideo: false),
        // const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}
