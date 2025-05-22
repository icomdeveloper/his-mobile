import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/recommended_videos_container.dart';

class RecommendedVideosList extends StatelessWidget {
  const RecommendedVideosList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 2,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => const RecommendedVideosContainer(),
    );
  }
}
