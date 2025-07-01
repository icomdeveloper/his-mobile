part of 'bookmarks_cubit.dart';

@immutable
sealed class BookmarksState {}

final class BookmarksInitial extends BookmarksState {}

final class AddToBookmarksSuccess extends BookmarksState {}

final class AddToBookmarksFailure extends BookmarksState {
  final String errMessage;
  AddToBookmarksFailure({required this.errMessage});
}

final class RemoveFromBookmarksSuccess extends BookmarksState {}

final class RemoveFromBookmarksFailure extends BookmarksState {
  final String errMessage;
  RemoveFromBookmarksFailure({required this.errMessage});
}
