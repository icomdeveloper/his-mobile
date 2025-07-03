import 'package:flutter/material.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_article_widget.dart';

class ApprovedArticleSliverList extends StatelessWidget {
  const ApprovedArticleSliverList({super.key, required this.articles});
  final List<ArticleModel> articles;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemCount: articles.length,
      itemBuilder: (context, index) => ApprovedArticleWidget(
        article: articles[index],
      ),
    );
  }
}
