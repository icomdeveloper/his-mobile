import 'package:bloc/bloc.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:meta/meta.dart';

part 'delete_comment_state.dart';

class DeleteCommentCubit extends Cubit<DeleteCommentState> {
  DeleteCommentCubit(this.commentRepo) : super(DeleteCommentInitial());
  final CommentRepo commentRepo;
  Future<void> deleteComment({required int commentId}) async {
    emit(DeleteCommentLoading());
    final result = await commentRepo.deleteComment(commentId: commentId);
    if (isClosed) return;
    result.fold(
        (error) => emit(DeleteCommentFailure(errMesage: error.errMesage)),
        (success) => emit(DeleteCommentSuccess(message: success)));
  }
}
