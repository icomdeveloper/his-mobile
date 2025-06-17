import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:meta/meta.dart';

part 'get_articles_state.dart';

class GetArticlesCubit extends Cubit<GetArticlesState> {
  GetArticlesCubit(this.showMediaRepo) : super(GetArticlesInitial());
  final ShowMediaRepo showMediaRepo;

  Future<void> getArticles() async {
    emit(GetArticlesLoading());
    var result = await showMediaRepo.showArticles();
    result.fold(
        (error) => emit(GetArticlesFailure(errMessage: error.errMesage)),
        (success) => emit(GetArticlesSuccess(articleList: success)));
  }
}
