import 'package:flutter/material.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class VideoCardList extends StatelessWidget {
  const VideoCardList({
    super.key,
    this.isBookmark = false,
  });
  final bool isBookmark;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 4,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => VideoCardWidget(
        isbookmark: isBookmark,
      ),
    );
  }
}
