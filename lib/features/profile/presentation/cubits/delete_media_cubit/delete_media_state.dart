part of 'delete_media_cubit.dart';

@immutable
sealed class DeleteMediaState {}

final class DeleteMediaInitial extends DeleteMediaState {}

final class DeleteMediaLoading extends DeleteMediaState {}

final class DeleteMediaSuccess extends DeleteMediaState {
  final String message;
  DeleteMediaSuccess({required this.message});
}

final class DeleteMediaFailure extends DeleteMediaState {
  final String errMessage;
  DeleteMediaFailure({required this.errMessage});
}
