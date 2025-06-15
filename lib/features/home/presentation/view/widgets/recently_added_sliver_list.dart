import 'package:flutter/material.dart';
import 'package:his/features/category/data/model/media_model.dart';

import 'recently_added_widget.dart';

class RecentlyAddedSliverList extends StatelessWidget {
  const RecentlyAddedSliverList({super.key, required this.recentlyAdded});
  final List<MediaModel> recentlyAdded;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: recentlyAdded.length,
      itemBuilder: (_, index) => RecentlyAddedWidget(
        mediaModel: recentlyAdded[index],
      ),
    );
  }
}
