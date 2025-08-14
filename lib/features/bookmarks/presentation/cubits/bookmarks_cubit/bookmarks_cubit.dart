import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:meta/meta.dart';

part 'bookmarks_state.dart';

class BookmarksCubit extends Cubit<BookmarksState> {
  BookmarksCubit(this.bookmarksRepo) : super(BookmarksInitial());
  final BookmarksRepo bookmarksRepo;

  Future<void> addToBookmarks({int? mediaId, int? articleId}) async {
    emit(BookmarksInitial());
    final result = await bookmarksRepo.addToBookmarks(
        mediaId: mediaId, articleId: articleId);
    if (isClosed) return;
    result.fold(
        (error) => emit(AddToBookmarksFailure(errMessage: error.errMesage)),
        (success) => emit(AddToBookmarksSuccess()));
  }

  Future<void> removeFromBookmarks({int? mediaId, int? articleId}) async {
    emit(BookmarksInitial());
    final result = await bookmarksRepo.removeFromBookmarks(
        mediaId: mediaId, articleId: articleId);
    if (isClosed) return;
    result.fold(
        (error) =>
            emit(RemoveFromBookmarksFailure(errMessage: error.errMesage)),
        (success) => emit(RemoveFromBookmarksSuccess()));
  }
}
