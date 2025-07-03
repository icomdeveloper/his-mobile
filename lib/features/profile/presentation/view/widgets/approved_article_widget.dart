import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:his/features/home/presentation/view/widgets/article_widget.dart';

class ApprovedArticleWidget extends StatelessWidget {
  const ApprovedArticleWidget({super.key, required this.article});
  final ArticleModel article;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArticleWidget(articleModel: article),
        const SizedBox(height: 12),
        const Text(
          'Approved on May 26, 2025 at 10:30 AM',
          style: Styles.regularRoboto12,
        ),
      ],
    );
  }
}
