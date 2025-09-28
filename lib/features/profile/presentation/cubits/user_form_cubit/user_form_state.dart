part of 'user_form_cubit.dart';

@immutable
sealed class UserFormState {}

final class UserFormInitial extends UserFormState {}

final class UserFormLoading extends UserFormState {}

final class UserFormSuccess extends UserFormState {
  final UserFormModel userFormModel;
  UserFormSuccess({required this.userFormModel});
}

final class UserFormFailure extends UserFormState {
  final String errMesage;
  UserFormFailure({required this.errMesage});
}
