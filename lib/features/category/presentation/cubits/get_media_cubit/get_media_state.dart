part of 'get_media_cubit.dart';

@immutable
sealed class GetMediaState {}

final class GetMediaInitial extends GetMediaState {}

final class GetMediaLoading extends GetMediaState {}

final class GetMediaSuccess extends GetMediaState {
  final List<MediaModel> mediaList;
  GetMediaSuccess({required this.mediaList});
}

final class GetMediaFailure extends GetMediaState {
  final String message;
  GetMediaFailure({required this.message});
}
