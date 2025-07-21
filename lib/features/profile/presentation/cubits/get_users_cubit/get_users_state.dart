part of 'get_users_cubit.dart';

@immutable
sealed class GetUsersState {}

final class GetUsersInitial extends GetUsersState {}

final class GetUsersSuccess extends GetUsersState {
  final List<UserInformation> users;
  GetUsersSuccess({required this.users});
}

final class GetUsersFailure extends GetUsersState {
  final String errMesage;
  GetUsersFailure({required this.errMesage});
}
