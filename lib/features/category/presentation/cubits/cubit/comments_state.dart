part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class AddCommentLoading extends CommentsState {}

final class AddCommentsFailure extends CommentsState {
  final String message;
  AddCommentsFailure({required this.message});
}

final class AddCommentSuccess extends CommentsState {}
