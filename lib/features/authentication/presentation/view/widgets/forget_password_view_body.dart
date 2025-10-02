import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/auth_vaildation.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/authentication/presentation/view/register_view.dart';
import 'package:his/features/authentication/presentation/view/widgets/authentication_text_form_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                SizedBox(
                    width: 98.2.w,
                    child: AspectRatio(
                        aspectRatio: 98.2.w / 70.86.h,
                        child: SvgPicture.asset(Assets.assetsImagesAppLogo))),
                const SizedBox(
                  height: 32,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 320.w),
                  child: GradientText('Forgot password',
                      style: Styles.semiBoldPoppins24,
                      gradientType: GradientType.linear,
                      stops: const [
                        0.26,
                        1
                      ],
                      colors: const [
                        AppColors.primaryColor,
                        Color(0xff263238),
                      ]),
                ),
                const SizedBox(
                  height: 4,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 268.w),
                  child: Text(
                    'Please enter your email to reset the password',
                    style:
                        Styles.regularPoppins12.copyWith(color: AppColors.grey),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text('Email Address', style: Styles.semiBoldPoppins12),
                const SizedBox(
                  height: 4,
                ),
                AuthenticationTextFormField(
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter an email address';
                    } else if (isValidEmail(email)) {
                      return null;
                    } else {
                      return 'Please enter a valid email address';
                    }
                  },
                  prefixIcon: SvgPicture.asset(
                    Assets.assetsImagesProfile,
                  ),
                  controller: context.read<AuthCubit>().emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(
                  height: 26,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordFailure) {
                      showCustomSnackBar(
                          message: state.message, context: context);
                    }
                    if (state is ForgetPasswordSuccess) {
                      showCustomSnackBar(
                          message: state.message,
                          context: context,
                          backgroundColor: const Color(0xFF0F8737));

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginView()));
                    }
                  },
                  builder: (context, state) {
                    return state is ForgetPasswordLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ))
                        : CustomTextButton(
                            text: 'Reset Password',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                context.read<AuthCubit>().forgetPassword();
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                          );
                  },
                ),
                // const SizedBox(
                //   height: 24,
                // ),
                // const OrDividerWidget(),
                // const SizedBox(
                //   height: 12,
                // ),
                // SocialAuthButton(
                //   onPressed: () {
                //     context.read<AuthCubit>().signInWithGoogle();
                //   },
                //   image: Assets.assetsImagesGoogle,
                //   text: 'Continue with Google',
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                // SocialAuthButton(
                //   onPressed: () {
                //     // context.read<AuthCubit>().signInWithApple();
                //   },
                //   image: Assets.assetsImagesApple,
                //   text: 'Continue with Apple',
                // ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: Text.rich(TextSpan(
                    text: 'Don\'t have an account ? ',
                    style: Styles.regularPoppins12,
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: Styles.semiBoldPoppins12.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      const RegisterView(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      FadeTransition(
                                          opacity: animation, child: child),
                                ));
                          },
                      ),
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
