import 'package:flutter/material.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class VideoCardSliverList extends StatelessWidget {
  const VideoCardSliverList({
    super.key,
    this.isBookmark = false,
    required this.mediaList,
  });
  final bool isBookmark;
  final List<MediaModel> mediaList;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: mediaList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => VideoCardWidget(
        mediaModel: mediaList[index],
        isbookmark: isBookmark,
      ),
    );
  }
}
