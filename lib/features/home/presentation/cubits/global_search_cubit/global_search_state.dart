part of 'global_search_cubit.dart';

@immutable
sealed class GlobalSearchState {}

final class GlobalSearchInitial extends GlobalSearchState {}

final class GlobalSearchMediaSuccess extends GlobalSearchState {
  final List<MediaModel> mediaList;
  GlobalSearchMediaSuccess({required this.mediaList});
}

final class GlobalSearchArticleSuccess extends GlobalSearchState {
  final List<ArticleModel> articleList;
  GlobalSearchArticleSuccess({required this.articleList});
}

final class GlobalSearchFailure extends GlobalSearchState {
  final String message;
  GlobalSearchFailure({required this.message});
}
