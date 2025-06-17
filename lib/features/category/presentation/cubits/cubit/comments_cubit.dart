import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/features/category/data/model/comment_model.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit(this.commentRepo) : super(CommentsInitial());
  final CommentRepo commentRepo;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  Future<void> addComment({required int mediaId}) async {
    emit(AddCommentLoading());
    final comment = CommentModel(
      mediaId: mediaId,
      userId: getUserData().userInfo!.id!,
      content: commentController.text,
    );
    commentController.clear();
    final result = await commentRepo.addComment(comment: comment);
    result.fold((error) => emit(AddCommentsFailure(message: error.errMesage)),
        (r) => emit(AddCommentSuccess()));
  }

  Future<void> addReply({required int mediaId, required int parentId}) async {
    emit(AddReplyLoading());
    final comment = CommentModel(
      mediaId: mediaId,
      userId: getUserData().userInfo!.id!,
      parentId: parentId,
      content: replyController.text,
    );
    replyController.clear();
    final result = await commentRepo.addComment(comment: comment);
    result.fold((error) => emit(AddReplyFailure(message: error.errMesage)),
        (r) => emit(AddReplytSuccess()));
  }
}
