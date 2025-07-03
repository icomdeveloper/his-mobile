part of 'delete_user_cubit.dart';

@immutable
sealed class DeleteUserState {}

final class DeleteUserInitial extends DeleteUserState {}

final class DeleteUserLoading extends DeleteUserState {}

final class DeleteUserSuccess extends DeleteUserState {
  final String message;
  DeleteUserSuccess({required this.message});
}

final class DeleteUserFailure extends DeleteUserState {
  final String errMessage;
  DeleteUserFailure({required this.errMessage});
}
