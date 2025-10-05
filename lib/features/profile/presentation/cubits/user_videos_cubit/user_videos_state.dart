part of 'user_videos_cubit.dart';

@immutable
sealed class UserVideosState {}

final class UserVideosInitial extends UserVideosState {}

final class GetUserVideosSuccess extends UserVideosState {
  final Map<String, List<MediaModel>> mediaMap;
  GetUserVideosSuccess({required this.mediaMap});
}

final class GetUserVideosFailure extends UserVideosState {
  final String errMessage;
  GetUserVideosFailure({required this.errMessage});
}

final class GetUserVideosLoading extends UserVideosState {}
