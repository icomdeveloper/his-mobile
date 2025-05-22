import 'package:flutter/material.dart';
import 'package:his/features/bookmarks/presentation/view/widgets/recently_bookmarks_widget.dart';

class RecentlyBookMarksSliverList extends StatelessWidget {
  const RecentlyBookMarksSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: 4,
      itemBuilder: (_, index) => const RecentlyBookMarksWidget(),
    );
  }
}
