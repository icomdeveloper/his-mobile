part of 'get_comments_cubit.dart';

@immutable
sealed class GetCommentsState {}

final class GetCommentsInitial extends GetCommentsState {}

final class GetCommentsLoading extends GetCommentsState {}

final class GetCommentsFailure extends GetCommentsState {
  final String message;
  GetCommentsFailure({required this.message});
}

final class GetCommentsSuccess extends GetCommentsState {
  final List<CommentsModel> comments;
  GetCommentsSuccess({required this.comments});
}
