part of 'get_bookmarks_articles_cubit.dart';

@immutable
sealed class GetBookmarksArticlesState {}

final class GetBookmarksArticlesInitial extends GetBookmarksArticlesState {}

final class GetBookmarksArticlesLoading extends GetBookmarksArticlesState {}

final class GetBookmarksArticlesSuccess extends GetBookmarksArticlesState {
  final List<ArticleModel> articleList;
  GetBookmarksArticlesSuccess({required this.articleList});
}

final class GetBookmarksArticlesFailure extends GetBookmarksArticlesState {
  final String errMessage;
  GetBookmarksArticlesFailure({required this.errMessage});
}
