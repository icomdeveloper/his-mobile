import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_item.dart';

class FeaturedVideosPageView extends StatelessWidget {
  const FeaturedVideosPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: const [
        FeaturedVideosItem(),
        FeaturedVideosItem(),
        FeaturedVideosItem(),
      ],
    );
  }
}
