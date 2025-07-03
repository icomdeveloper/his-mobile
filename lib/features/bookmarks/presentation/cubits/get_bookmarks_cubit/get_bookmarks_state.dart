part of 'get_bookmarks_cubit.dart';

@immutable
sealed class GetBookmarksState {}

final class GetBookmarksInitial extends GetBookmarksState {}

final class GetBookmarksLoading extends GetBookmarksState {}

final class GetBookmarksSuccess extends GetBookmarksState {
  final List<MediaModel> mediaList;

  GetBookmarksSuccess({
    required this.mediaList,
  });
}

final class GetBookmarksFailure extends GetBookmarksState {
  final String errMessage;
  GetBookmarksFailure({required this.errMessage});
}
