part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class YearUpdated extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  final String name;
  final String phone;

  EditProfileSuccess({required this.name, required this.phone});
}

final class EditProfileFailure extends EditProfileState {
  final String errMessage;
  EditProfileFailure({required this.errMessage});
}
