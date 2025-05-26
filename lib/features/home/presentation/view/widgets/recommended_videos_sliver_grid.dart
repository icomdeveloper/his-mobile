import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/recommended_videos_widget.dart';

class RecommendedVideosSliverGrid extends StatelessWidget {
  const RecommendedVideosSliverGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return SliverGrid.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: isPortrait ? 165 / 180 : 500 / 400,
          crossAxisSpacing: 12,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (_, index) => const RecommendedVideosWidget());
  }
}
