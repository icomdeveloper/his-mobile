import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/features/profile/data/model/reset_password_model.dart';
import 'package:his/features/profile/data/repo/reset_password_repo.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordRepo) : super(ResetPasswordInitial());
  final ResetPasswordRepo resetPasswordRepo;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> resetPassword() async {
    emit(ResetPasswordLoading());
    ResetPasswordModel resetPasswordModel = ResetPasswordModel(
      currentPassword: currentPasswordController.text,
      password: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
      email: getUserData().userInfo!.email!,
      token: getUserData().token!,
    );
    var result = await resetPasswordRepo.resetPassword(
        resetPasswordModel: resetPasswordModel);
    result.fold((error) => emit(ResetPasswordFailure(message: error.errMesage)),
        (success) => emit(ResetPasswordSuccess()));
  }
}
