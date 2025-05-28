import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:his/features/authentication/data/models/register_model.dart';
import 'package:his/features/authentication/data/models/register_success_model.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final AuthRepo authRepo;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  Future<void> register() async {
    emit(RegisterLoading());
    RegisterModel registerModel = RegisterModel(
      username: usernameController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      email: emailController.text,
      id: '3',
      name: nameController.text,
      phone: phoneController.text,
      role: 'user',
    );

    var result = await authRepo.register(registerModel: registerModel);
    result.fold((error) => emit(RegisterFailure(message: error.errMesage)),
        (success) => emit(RegisterSuccess(registerSuccessModel: success)));
  }
}
