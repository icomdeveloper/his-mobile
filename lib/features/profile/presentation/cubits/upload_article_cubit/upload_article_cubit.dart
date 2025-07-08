import 'package:bloc/bloc.dart';
import 'package:his/features/profile/data/model/upload_article_model.dart';
import 'package:his/features/profile/data/repo/upload_article_repo.dart';
import 'package:meta/meta.dart';

part 'upload_article_state.dart';

class UploadArticleCubit extends Cubit<UploadArticleState> {
  UploadArticleCubit(this.uploadArticleRepo) : super(UploadArticleInitial());
  final UploadArticleRepo uploadArticleRepo;

  Future<void> uploadArticle(
      {required UploadArticleModel uploadArticleModel}) async {
    emit(UploadArticleLoading());
    var result = await uploadArticleRepo.uploadArticle(
        uploadArticleModel: uploadArticleModel);
    if (isClosed) return;
    result.fold((error) => emit(UploadArticleFailure(message: error.errMesage)),
        (r) => emit(UploadArticleSuccess()));
  }
}
