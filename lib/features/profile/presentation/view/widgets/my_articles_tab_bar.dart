import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/home/presentation/view/widgets/articles_sliver_list.dart';
import 'package:his/features/profile/presentation/cubits/user_articles_cubit/user_articles_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyArticlesTabBar extends StatelessWidget {
  const MyArticlesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        BlocBuilder<UserArticlesCubit, UserArticlesState>(
          builder: (context, state) {
            if (state is UserArticlesSuccess) {
              if (state.articles.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'You have no articles yet',
                      style: Styles.semiBoldPoppins14,
                    ),
                  ),
                );
              }
              return ArticlesSliverList(
                articleList: state.articles,
              );
            } else if (state is UserArticlesFailure) {
              return SliverToBoxAdapter(
                  child: SizedBox(
                      height: 150,
                      child: CustomErrorWidget(
                        errorMessage: state.message,
                        onTap: () {
                          context.read<UserArticlesCubit>().getUserArticles();
                        },
                      )));
            } else {
              return Skeletonizer.sliver(
                  child: ArticlesSliverList(
                articleList: dummyArticleList.take(2).toList(),
              ));
            }
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}
