import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/features/category/data/model/add_comment_model.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:his/features/home/data/models/comments_model/reply_model.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit(this.commentRepo) : super(CommentsInitial());
  final CommentRepo commentRepo;
  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  Future<void> addComment({required int mediaId}) async {
    emit(AddCommentLoading());
    final comment = AddCommentModel(
      mediaId: mediaId,
      userId: getUserData().userInfo!.id!,
      content: commentController.text,
    );
    commentController.clear();
    final result = await commentRepo.addComment(comment: comment);
    result.fold((error) => emit(AddCommentsFailure(message: error.errMesage)),
        (comment) => emit(AddCommentSuccess(comment: comment)));
  }

  Future<void> addReply({required int mediaId, required int parentId}) async {
    emit(AddReplyLoading());
    final reply = AddCommentModel(
      mediaId: mediaId,
      userId: getUserData().userInfo!.id!,
      parentId: parentId,
      content: replyController.text,
    );
    replyController.clear();
    final result = await commentRepo.addReply(reply: reply);
    result.fold((error) => emit(AddReplyFailure(message: error.errMesage)),
        (reply) => emit(AddReplytSuccess(replyModel: reply)));
  }
}
