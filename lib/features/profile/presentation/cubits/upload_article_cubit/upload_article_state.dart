part of 'upload_article_cubit.dart';

@immutable
sealed class UploadArticleState {}

final class UploadArticleInitial extends UploadArticleState {}

final class UploadArticleLoading extends UploadArticleState {}

final class UploadArticleFailure extends UploadArticleState {
  final String message;
  UploadArticleFailure({required this.message});
}

final class UploadArticleSuccess extends UploadArticleState {}
