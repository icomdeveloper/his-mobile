import 'package:bloc/bloc.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:meta/meta.dart';

part 'get_bookmarks_articles_state.dart';

class GetBookmarksArticlesCubit extends Cubit<GetBookmarksArticlesState> {
  GetBookmarksArticlesCubit(this.bookmarksRepo)
      : super(GetBookmarksArticlesInitial());
  final BookmarksRepo bookmarksRepo;
  Future<void> getBookmarksArticles() async {
    emit(GetBookmarksArticlesLoading());
    final result = await bookmarksRepo.getBookmarksArticles();
    result.fold(
        (error) =>
            emit(GetBookmarksArticlesFailure(errMessage: error.errMesage)),
        (success) => emit(GetBookmarksArticlesSuccess(articleList: success)));
  }
}
