part of 'get_user_info_cubit.dart';

@immutable
sealed class GetUserInfoState {}

final class GetUserInfoInitial extends GetUserInfoState {}

final class GetUserInfoSuccess extends GetUserInfoState {
  final UserInformation userInfo;
  GetUserInfoSuccess({required this.userInfo});
}

final class GetUserInfoFailure extends GetUserInfoState {
  final String errMesage;
  GetUserInfoFailure({required this.errMesage});
}
