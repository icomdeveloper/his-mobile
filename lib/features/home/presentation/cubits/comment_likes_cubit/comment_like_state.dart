part of 'comment_like_cubit.dart';

@immutable
sealed class CommentLikeState {}

final class CommentLikeInitial extends CommentLikeState {}

final class AddLikeSuccess extends CommentLikeState {}

final class AddLikeFailure extends CommentLikeState {
  final String message;
  AddLikeFailure({required this.message});
}

final class DeleteLikeSuccess extends CommentLikeState {}

final class DeleteLikeFailure extends CommentLikeState {
  final String message;
  DeleteLikeFailure({required this.message});
}
