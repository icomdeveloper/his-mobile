part of 'delete_comment_cubit.dart';

@immutable
sealed class DeleteCommentState {}

final class DeleteCommentInitial extends DeleteCommentState {}

final class DeleteCommentLoading extends DeleteCommentState {}

final class DeleteCommentSuccess extends DeleteCommentState {
  final String message;
  DeleteCommentSuccess({required this.message});
}

final class DeleteCommentFailure extends DeleteCommentState {
  final String errMesage;
  DeleteCommentFailure({required this.errMesage});
}
