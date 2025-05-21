import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/recommended_videos_container.dart';

class RecommendedVideosList extends StatelessWidget {
  const RecommendedVideosList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 8,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => const RecommendedVideosContainer(),
    );
  }
}
