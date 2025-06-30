import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/auth_vaildation.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/authentication/presentation/view/widgets/authentication_text_form_field.dart';
import 'package:his/features/profile/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'Change Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Current Password',
                      style: Styles.semiBoldPoppins14),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please enter your current password';
                      } else {
                        return null;
                      }
                    },
                    controller: context
                        .read<ResetPasswordCubit>()
                        .currentPasswordController,
                    prefixIcon: SvgPicture.asset(
                      Assets.assetsImagesPassword,
                    ),
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    'New Password',
                    style: Styles.semiBoldPoppins14,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please enter your new password';
                      } else {
                        return validatePassword(password);
                      }
                    },
                    controller: context
                        .read<ResetPasswordCubit>()
                        .newPasswordController,
                    prefixIcon: SvgPicture.asset(Assets.assetsImagesPassword),
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                    'Confirm Password',
                    style: Styles.semiBoldPoppins14,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    validator: (confirmPassword) {
                      if (confirmPassword == null || confirmPassword.isEmpty) {
                        return 'Please confirm your password';
                      } else {
                        if (confirmPassword ==
                            context
                                .read<ResetPasswordCubit>()
                                .newPasswordController
                                .text) {
                          return null;
                        } else {
                          return 'Passwords do not match';
                        }
                      }
                    },
                    controller: context
                        .read<ResetPasswordCubit>()
                        .confirmPasswordController,
                    prefixIcon: SvgPicture.asset(Assets.assetsImagesPassword),
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                    listener: (context, state) {
                      if (state is ResetPasswordSuccess) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Password updated successfully'),
                        ));
                        Navigator.pop(context);
                      }
                      if (state is ResetPasswordFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.message),
                        ));
                      }
                    },
                    builder: (context, state) {
                      return state is ResetPasswordLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomTextButton(
                              text: 'Update Password',
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  setState(() {
                                    autovalidateMode = AutovalidateMode.always;
                                  });
                                  return;
                                }
                                context
                                    .read<ResetPasswordCubit>()
                                    .resetPassword();
                              });
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
