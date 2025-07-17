part of 'edit_media_cubit.dart';

@immutable
sealed class EditMediaState {}

final class EditMediaInitial extends EditMediaState {}

final class EditMediaLoading extends EditMediaState {}

final class EditMediaSuccess extends EditMediaState {
  final String message;
  EditMediaSuccess({required this.message});
}

final class EditMediaFailure extends EditMediaState {
  final String errMessage;
  EditMediaFailure({required this.errMessage});
}
