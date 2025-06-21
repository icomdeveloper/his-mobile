part of 'upload_media_cubit.dart';

@immutable
sealed class UploadMediaState {}

final class UploadMediaInitial extends UploadMediaState {}

final class UploadMediaLoading extends UploadMediaState {}

final class UploadMediaFailure extends UploadMediaState {
  final String message;
  UploadMediaFailure({required this.message});
}

final class UploadMediaSuccess extends UploadMediaState {}
