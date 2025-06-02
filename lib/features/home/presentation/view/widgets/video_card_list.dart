import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class VideoCardList extends StatelessWidget {
  const VideoCardList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 2,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => const VideoCardWidget(),
    );
  }
}
