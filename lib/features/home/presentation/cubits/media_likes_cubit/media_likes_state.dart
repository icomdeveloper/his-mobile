part of 'media_likes_cubit.dart';

@immutable
sealed class MediaLikesState {}

final class MediaLikesInitial extends MediaLikesState {}

final class AddLikeSuccess extends MediaLikesState {}

final class DeleteLikeSuccess extends MediaLikesState {}

final class DeleteLikeFailure extends MediaLikesState {
  final String message;
  DeleteLikeFailure({required this.message});
}

final class AddLikeFailure extends MediaLikesState {
  final String message;
  AddLikeFailure({required this.message});
}
