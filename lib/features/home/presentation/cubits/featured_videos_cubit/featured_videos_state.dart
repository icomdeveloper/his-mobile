part of 'featured_videos_cubit.dart';

@immutable
sealed class FeaturedVideosState {}

final class FeaturedVideosInitial extends FeaturedVideosState {}

final class FeaturedVideosLoading extends FeaturedVideosState {}

final class FeaturedVideosSuccess extends FeaturedVideosState {
  final List<MediaModel> mediaList;
  FeaturedVideosSuccess({required this.mediaList});
}

final class FeaturedVideosFailure extends FeaturedVideosState {
  final String errMessage;
  FeaturedVideosFailure({required this.errMessage});
}
