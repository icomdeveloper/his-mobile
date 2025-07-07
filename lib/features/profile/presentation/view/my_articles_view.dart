import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/my_article_view_body.dart';

class MyArticlesView extends StatelessWidget {
  const MyArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'My Articles', centerTitle: true),
      backgroundColor: Colors.white,
      body: const MyArticleViewBody(),
      // body:
    );
  }
}
