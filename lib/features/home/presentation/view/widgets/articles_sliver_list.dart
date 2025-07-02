import 'package:flutter/material.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:his/features/home/presentation/view/widgets/article_widget.dart';

class ArticlesSliverList extends StatelessWidget {
  const ArticlesSliverList({
    super.key,
    required this.articleList,
    this.isBookmark = false,
  });
  final bool isBookmark;

  final List<ArticleModel> articleList;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: articleList.length,
      itemBuilder: (context, index) => ArticleWidget(
        articleModel: articleList[index],
        isbookmark: isBookmark,
      ),
    );
  }
}
