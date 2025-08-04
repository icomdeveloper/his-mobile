import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/core/repo/notifications_repo.dart';
import 'package:his/features/authentication/data/models/login_model.dart';
import 'package:his/features/authentication/data/models/register_model.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, this.notificationsRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  final NotificationsRepo notificationsRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  File? profileImage;
  Future<void> loginWithEmailAndPassword() async {
    emit(LoginLoading());
    LoginModel loginModel = LoginModel(
      login: emailController.text,
      password: passwordController.text,
    );

    var result = await authRepo.login(loginModel: loginModel);
    try {
      await sendFCMToken();
    } catch (e) {
      if (isClosed) return;
      if (result.isLeft()) {
        emit(LoginFailure(message: result.fold((l) => l.errMesage, (r) => '')));
        return;
      }

      emit(LoginFailure(message: 'Something went wrong , try again'));
      return;
    }
    if (isClosed) return;
    passwordController.clear();
    result.fold((error) => emit(LoginFailure(message: error.errMesage)),
        (success) => emit(LoginSuccess(userData: success)));
  }

  Future<void> register() async {
    emit(RegisterLoading());
    RegisterModel registerModel = RegisterModel(
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      email: emailController.text,
      name: nameController.text,
      phone: phoneController.text,
      image: profileImage,
    );

    var result = await authRepo.register(registerModel: registerModel);
    try {
      await sendFCMToken();
    } catch (e) {
      emit(RegisterFailure(message: 'Something went wrong , try again'));
      return;
    }
    if (isClosed) return;
    result.fold((error) => emit(RegisterFailure(message: error.errMesage)),
        (success) => emit(RegisterSuccess(registerSuccessModel: success)));
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold((error) => emit(LoginFailure(message: error.errMesage)),
        (success) => emit(LoginSuccess(userData: success)));
  }

  // Future<void> signInWithApple() async {
  //   emit(LoginLoading());
  //   var result = await authRepo.signInWithApple();
  //   result.fold((error) => emit(LoginFailure(message: error.errMesage)),
  //       (success) => emit(LoginSuccess(userData: success)));
  // }

  Future<dynamic> sendFCMToken() async {
    final result = await notificationsRepo.sendFCMToken();
    return result;
  }
}
