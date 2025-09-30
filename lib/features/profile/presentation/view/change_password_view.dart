import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/auth_vaildation.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
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
  bool hideCurrentPassword = true;
  bool hidNewPassword = true;
  bool hideConfirmPassword = true;
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
                    obscureText: hideCurrentPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideCurrentPassword = !hideCurrentPassword;
                        });
                      },
                      icon: hideCurrentPassword
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 18,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 18,
                            ),
                    ),
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
                    obscureText: hidNewPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidNewPassword = !hidNewPassword;
                        });
                      },
                      icon: hidNewPassword
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 18,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 18,
                            ),
                    ),
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
                    obscureText: hideConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword = !hideConfirmPassword;
                        });
                      },
                      icon: hideConfirmPassword
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 18,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 18,
                            ),
                    ),
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
                        showCustomSnackBar(
                            message: 'Password updated successfully',
                            context: context,
                            backgroundColor: const Color(0xFF0F8737));
                        Navigator.pop(context);
                      }

                      if (state is ResetPasswordFailure) {
                        showCustomSnackBar(
                          message: state.message,
                          context: context,
                        );
                      }
                    },
                    builder: (context, state) {
                      return state is ResetPasswordLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ))
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
