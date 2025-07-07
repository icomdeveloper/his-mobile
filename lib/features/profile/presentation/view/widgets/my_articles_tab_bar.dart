import 'package:flutter/material.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_article_sliver_list.dart';

class MyArticlesTabBar extends StatelessWidget {
  const MyArticlesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          ApprovedArticleSliverList(
            articles: [],
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
