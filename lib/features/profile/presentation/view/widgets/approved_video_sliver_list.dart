import 'package:flutter/material.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_video_card_widget.dart';

class ApprovedVideosSliverList extends StatelessWidget {
  const ApprovedVideosSliverList({super.key, required this.mediaList});
  final List<MediaModel> mediaList;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemCount: mediaList.length,
      itemBuilder: (context, index) => ApprovedVideoCardWidget(
        mediaModel: mediaList[index],
      ),
    );
  }
}
