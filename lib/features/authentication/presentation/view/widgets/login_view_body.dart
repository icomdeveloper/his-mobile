import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/auth_vaildation.dart';
import 'package:his/core/helpers/nav_bar_visibility_provider.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';
import 'package:his/features/authentication/presentation/view/register_view.dart';
import 'package:his/features/authentication/presentation/view/widgets/authentication_text_form_field.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isPasswordVisible = true;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  child: GradientText('Sign in to your account , Login Now !',
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 268.w),
                  child: Text(
                    'Log in to stay connected and explore expert videos and articles ',
                    style:
                        Styles.regularPoppins12.copyWith(color: AppColors.grey),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text('Email Address / Phone Number',
                    style: Styles.semiBoldPoppins12),
                const SizedBox(
                  height: 4,
                ),
                AuthenticationTextFormField(
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter an email address or phone number';
                    } else if (isValidEmail(email) ||
                        isValidPhoneNumber(email)) {
                      return null;
                    } else {
                      return 'Please enter a valid email address or phone number';
                    }
                  },
                  prefixIcon: SvgPicture.asset(
                    Assets.assetsImagesProfile,
                  ),
                  controller: context.read<AuthCubit>().emailController,
                  hintText: 'Email Address / Phone Number',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'password',
                  style: Styles.semiBoldPoppins12,
                ),
                const SizedBox(
                  height: 4,
                ),
                AuthenticationTextFormField(
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    prefixIcon: SvgPicture.asset(Assets.assetsImagesPassword),
                    controller: context.read<AuthCubit>().passwordController,
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    obscureText: isPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: isPasswordVisible
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              size: 18,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              size: 18,
                            ),
                    )),
                const SizedBox(
                  height: 26,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      showCustomSnackBar(
                          message: state.message, context: context);
                    }
                    if (state is LoginSuccess) {
                      Prefs.setBool(PrefsKeys.isLoggedIn, true);
                      Provider.of<NavBarVisibilityProvider>(context,
                              listen: false)
                          .show();
                      Navigator.pushReplacementNamed(
                        context,
                        MainView.routeName,
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is LoginLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomTextButton(
                            text: 'Log in',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                context
                                    .read<AuthCubit>()
                                    .loginWithEmailAndPassword();
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
                            Navigator.push(
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
