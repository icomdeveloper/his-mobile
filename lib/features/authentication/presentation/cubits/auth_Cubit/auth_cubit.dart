import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/authentication/data/models/login_model.dart';
import 'package:his/features/authentication/data/models/register_model.dart';
import 'package:his/features/authentication/data/models/register_success_model/register_success_model.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  Future<void> loginWithEmailAndPassword() async {
    emit(LoginLoading());
    LoginModel loginModel = LoginModel(
      login: emailController.text,
      password: passwordController.text,
    );

    var result = await authRepo.login(loginModel: loginModel);
    passwordController.clear();
    log('Step1 ==>$result');
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
    );

    var result = await authRepo.register(registerModel: registerModel);
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
}
