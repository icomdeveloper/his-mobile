import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/home/presentation/cubits/get_articles_cubit/get_articles_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/articles_sliver_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ArticleListBlocBuilder extends StatelessWidget {
  const ArticleListBlocBuilder({
    super.key,
    this.onEmptyList,
  });
  final VoidCallback? onEmptyList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetArticlesCubit, GetArticlesState>(
      builder: (context, state) {
        if (state is GetArticlesSuccess) {
          if (state.articleList.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onEmptyList?.call();
            });
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return ArticlesSliverList(
            articleList: state.articleList,
          );
        } else if (state is GetArticlesFailure) {
          return SliverToBoxAdapter(
              child: SizedBox(
            height: 200.h,
            child: CustomErrorWidget(
              errorMessage: state.errMessage,
              onTap: () {
                context.read<GetArticlesCubit>().getArticles();
              },
            ),
          ));
        } else {
          return Skeletonizer.sliver(
              child: ArticlesSliverList(
            articleList: dummyArticleList,
          ));
        }
      },
    );
  }
}
