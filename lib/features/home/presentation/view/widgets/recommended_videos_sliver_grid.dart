import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/recommended_videos_widget.dart';

class RecommendedVideosSliverGrid extends StatelessWidget {
  const RecommendedVideosSliverGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 165 / 180,
          crossAxisSpacing: 12,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (_, index) => const RecommendedVideosWidget());
  }
}
