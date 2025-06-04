import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_item.dart';

class FeaturedVideosPageView extends StatelessWidget {
  const FeaturedVideosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      padEnds: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: FeaturedVideosItem(),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
