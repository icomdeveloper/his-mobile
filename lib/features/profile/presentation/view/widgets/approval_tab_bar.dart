import 'package:flutter/material.dart';

import 'package:his/features/profile/presentation/view/widgets/approved_article_sliver_list.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_video_sliver_list.dart';

class ApprovalTabBar extends StatelessWidget {
  const ApprovalTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        ApprovedVideosSliverList(),
        SliverToBoxAdapter(child: SizedBox(height: 30)),
        ApprovedArticleSliverList(),
        SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
