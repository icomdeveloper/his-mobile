import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:his/features/bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';
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
      itemBuilder: (context, index) => BlocProvider(
        create: (context) => BookmarksCubit(getIt<BookmarksRepo>()),
        child: ArticleWidget(
          articleModel: articleList[index],
          isbookmark: isBookmark,
        ),
      ),
    );
  }
}
