part of 'media_details_cubit.dart';

@immutable
sealed class MediaDetailsState {}

final class MediaDetailsInitial extends MediaDetailsState {}

final class MediaDetailsLoading extends MediaDetailsState {}

final class MediaDetailsSuccess extends MediaDetailsState {
  final MediaModel mediaModel;
  MediaDetailsSuccess({required this.mediaModel});
}

final class MediaDetailsFailure extends MediaDetailsState {
  final String errMesage;
  MediaDetailsFailure({required this.errMesage});
}
