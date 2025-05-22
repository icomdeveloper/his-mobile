import 'package:flutter/material.dart';
import 'package:his/features/bookmarks/presentation/view/widgets/article_widget.dart';

class ArticlesSliverList extends StatelessWidget {
  const ArticlesSliverList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: 4,
      itemBuilder: (context, index) => const ArticleWidget(),
    );
  }
}
