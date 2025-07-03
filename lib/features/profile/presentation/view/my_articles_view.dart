import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_article_sliver_list.dart';

class MyArticlesView extends StatelessWidget {
  const MyArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, title: 'My Articles', centerTitle: true),
        backgroundColor: Colors.white,
        body: const Padding(
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
        ));
  }
}
