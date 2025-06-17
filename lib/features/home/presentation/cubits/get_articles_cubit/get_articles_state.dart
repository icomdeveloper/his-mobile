part of 'get_articles_cubit.dart';

@immutable
sealed class GetArticlesState {}

final class GetArticlesInitial extends GetArticlesState {}

final class GetArticlesLoading extends GetArticlesState {}

final class GetArticlesSuccess extends GetArticlesState {
  final List<ArticleModel> articleList;
  GetArticlesSuccess({required this.articleList});
}

final class GetArticlesFailure extends GetArticlesState {
  final String errMessage;
  GetArticlesFailure({required this.errMessage});
}
