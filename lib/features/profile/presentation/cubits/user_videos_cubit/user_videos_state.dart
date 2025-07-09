part of 'user_videos_cubit.dart';

@immutable
sealed class UserVideosState {}

final class UserVideosInitial extends UserVideosState {}

final class GetPendingSuccess extends UserVideosState {
  final List<MediaModel> mediaList;
  GetPendingSuccess({required this.mediaList});
}

final class GetPendingFailure extends UserVideosState {
  final String errMessage;
  GetPendingFailure({required this.errMessage});
}

final class GetPendingLoading extends UserVideosState {}

final class GetUserVideosSuccess extends UserVideosState {
  final List<MediaModel> mediaList;
  GetUserVideosSuccess({required this.mediaList});
}

final class GetUserVideosFailure extends UserVideosState {
  final String errMessage;
  GetUserVideosFailure({required this.errMessage});
}

final class GetUserVideosLoading extends UserVideosState {}
