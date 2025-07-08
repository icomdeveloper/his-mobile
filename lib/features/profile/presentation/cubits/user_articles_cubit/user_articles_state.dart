part of 'user_articles_cubit.dart';

@immutable
sealed class UserArticlesState {}

final class UserArticlesInitial extends UserArticlesState {}

final class UserArticlesLoading extends UserArticlesState {}

final class UserArticlesSuccess extends UserArticlesState {
  final List<ArticleModel> articles;
  UserArticlesSuccess({required this.articles});
}

final class UserArticlesFailure extends UserArticlesState {
  final String message;
  UserArticlesFailure({required this.message});
}
