part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class AddCommentLoading extends CommentsState {}

final class AddCommentsFailure extends CommentsState {
  final String message;
  AddCommentsFailure({required this.message});
}

final class AddCommentSuccess extends CommentsState {
  final CommentsModel comment;
  AddCommentSuccess({required this.comment});
}

final class AddReplyLoading extends CommentsState {}

final class AddReplyFailure extends CommentsState {
  final String message;
  AddReplyFailure({required this.message});
}

final class AddReplytSuccess extends CommentsState {
  final ReplyModel replyModel;
  AddReplytSuccess({required this.replyModel});
}
