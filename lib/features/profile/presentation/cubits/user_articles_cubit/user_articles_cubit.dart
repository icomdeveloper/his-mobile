import 'package:bloc/bloc.dart';
import 'package:his/features/home/data/models/article_model.dart';
import 'package:his/features/profile/data/repo/user_articles_repo.dart';
import 'package:meta/meta.dart';

part 'user_articles_state.dart';

class UserArticlesCubit extends Cubit<UserArticlesState> {
  UserArticlesCubit(this.userArticlesRepo) : super(UserArticlesInitial());
  final UserArticlesRepo userArticlesRepo;

  Future<void> getUserArticles() async {
    emit(UserArticlesLoading());
    final result = await userArticlesRepo.userArticles();
    if (isClosed) return;
    result.fold((failure) {
      emit(UserArticlesFailure(message: failure.errMesage));
    }, (data) {
      emit(UserArticlesSuccess(articles: data));
    });
  }
}
