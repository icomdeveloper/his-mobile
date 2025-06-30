import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_app_bar.dart';

import '../../../category/data/repo/show_media_repo.dart';
import '../cubits/get_articles_cubit/get_articles_cubit.dart';
import 'widgets/article_list_bloc_builder.dart';

class SeeAllArticlesView extends StatelessWidget {
  const SeeAllArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'All Articles', centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            BlocProvider(
              create: (context) =>
                  GetArticlesCubit(getIt<ShowMediaRepo>())..getArticles(),
              child: const ArticleListBlocBuilder(
                seeAll: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
