part of 'media_by_category_cubit.dart';

@immutable
sealed class MediaByCategoryState {}

final class MediaByCategoryInitial extends MediaByCategoryState {}

final class MediaByCategoryLoading extends MediaByCategoryState {}

final class MediaByCategoryFailure extends MediaByCategoryState {
  final String errMessage;
  MediaByCategoryFailure({required this.errMessage});
}

final class MediaByCategorySuccess extends MediaByCategoryState {
  final List<MediaModel> mediaList;
  MediaByCategorySuccess({required this.mediaList});
}
