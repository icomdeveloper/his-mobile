import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/bookmarks/presentation/view/widgets/article_widget.dart';

class ApprovedArticleWidget extends StatelessWidget {
  const ApprovedArticleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArticleWidget(),
        SizedBox(height: 12),
        Text(
          'Approved on May 26, 2025 at 10:30 AM',
          style: Styles.regularRoboto12,
        ),
      ],
    );
  }
}
