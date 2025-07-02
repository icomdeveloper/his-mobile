part of 'get_bookmarks_cubit.dart';

@immutable
sealed class GetBookmarksState {}

final class GetBookmarksInitial extends GetBookmarksState {}

final class GetBookmarksLoading extends GetBookmarksState {}

final class GetBookmarksSuccess extends GetBookmarksState {
  final List<MediaModel>? mediaList;
  final List<ArticleModel>? articleList;
  GetBookmarksSuccess({
    this.mediaList,
    this.articleList,
  });
}

final class GetBookmarksFailure extends GetBookmarksState {
  final String errMessage;
  GetBookmarksFailure({required this.errMessage});
}
