import 'package:flutter/material.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_article_widget.dart';

class ApprovedArticleSliverList extends StatelessWidget {
  const ApprovedArticleSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemCount: 2,
      itemBuilder: (context, index) => const ApprovedArticleWidget(),
    );
  }
}
