import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:meta/meta.dart';

part 'get_comments_state.dart';

class GetCommentsCubit extends Cubit<GetCommentsState> {
  GetCommentsCubit(this.commentRepo) : super(GetCommentsInitial());
  final CommentRepo commentRepo;

  Future<void> getComments({required int mediaId}) async {
    if (isClosed) return;
    emit(GetCommentsLoading());
    final result =
        await commentRepo.getComments(mediaId: mediaId, isArticle: false);
    if (isClosed) return;
    result.fold((error) => emit(GetCommentsFailure(message: error.errMesage)),
        (commentsList) => emit(GetCommentsSuccess(comments: commentsList)));
  }
}
