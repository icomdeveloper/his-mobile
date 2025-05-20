import 'package:flutter/material.dart';

import 'recently_added_widget.dart';

class RecentlyAddedSliverList extends StatelessWidget {
  const RecentlyAddedSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 4,
      itemBuilder: (_, index) => const RecentlyAddedWidget(),
    );
  }
}
