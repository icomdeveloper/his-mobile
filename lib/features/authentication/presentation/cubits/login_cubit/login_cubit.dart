import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/authentication/data/models/login_model.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoading());
    LoginModel loginModel = LoginModel(
      userName: usernameController.text,
      password: passwordController.text,
    );

    var result = await authRepo.login(loginModel: loginModel);
    log('Step1 ==>$result');
    result.fold((error) => emit(LoginFailure(message: error.errMesage)),
        (success) => emit(LoginSuccess(userData: success)));
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}
