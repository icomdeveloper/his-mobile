import 'package:flutter/material.dart';

import 'package:his/features/profile/presentation/view/widgets/approved_video_sliver_list.dart';

class PublishedTabBar extends StatelessWidget {
  const PublishedTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12)),
        ApprovedVideosSliverList(),
        SliverToBoxAdapter(child: SizedBox(height: 24))
      ],
    );
  }
}
