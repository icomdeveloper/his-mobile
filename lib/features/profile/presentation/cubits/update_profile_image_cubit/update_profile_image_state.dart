part of 'update_profile_image_cubit.dart';

@immutable
sealed class UpdateProfileImageState {}

final class UpdateProfileImageInitial extends UpdateProfileImageState {}

final class UpdateProfileImageLoading extends UpdateProfileImageState {}

final class UpdateProfileImageSuccess extends UpdateProfileImageState {
  final UserInformation userInformation;
  UpdateProfileImageSuccess({required this.userInformation});
}

final class UpdateProfileImageFailure extends UpdateProfileImageState {
  final String errMessage;
  UpdateProfileImageFailure({required this.errMessage});
}
