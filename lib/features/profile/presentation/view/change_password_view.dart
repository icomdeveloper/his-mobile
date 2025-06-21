import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/authentication/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'Change Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Current Password', style: Styles.semiBoldPoppins14),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
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
                CustomTextFormField(
                  controller:
                      context.read<ResetPasswordCubit>().newPasswordController,
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
                CustomTextFormField(
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Password updated successfully'),
                      ));
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const LoginView(),
                      //     ),
                      //     (route) => false);
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
                              context
                                  .read<ResetPasswordCubit>()
                                  .resetPassword();
                            });
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
