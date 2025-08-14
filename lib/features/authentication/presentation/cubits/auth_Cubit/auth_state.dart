part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccess extends AuthState {
  final UserData userData;
  LoginSuccess({required this.userData});
}

final class LoginLoading extends AuthState {}

final class YearUpdated extends AuthState {}

final class LoginFailure extends AuthState {
  final String message;
  LoginFailure({required this.message});
}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {
  final UserData registerSuccessModel;

  RegisterSuccess({required this.registerSuccessModel});
}

final class RegisterFailure extends AuthState {
  final String message;

  RegisterFailure({required this.message});
}
