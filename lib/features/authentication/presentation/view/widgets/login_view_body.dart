import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';
import 'package:his/features/authentication/presentation/view/register_view.dart';
import 'package:his/features/authentication/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/authentication/presentation/view/widgets/or_divider_widget.dart';
import 'package:his/features/authentication/presentation/view/widgets/social_auth_button.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.95,
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
                    width: 79.w,
                    child: AspectRatio(
                        aspectRatio: 79.w / 39.h,
                        child: SvgPicture.asset(Assets.assetsImagesLogo))),
                const SizedBox(
                  height: 32,
                ),
                GradientText('Sign in to your account , Login Now !',
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
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 268.w),
                  child: const Text(
                    'Log in to stay connected and explore expert videos and articles ',
                    style: Styles.regularRoboto12,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text('Email Address', style: Styles.semiBoldRoboto12),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  prefixIcon: SvgPicture.asset(
                    Assets.assetsImagesMail,
                  ),
                  controller: context.read<AuthCubit>().usernameController,
                  hintText: 'Email Address',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'password',
                  style: Styles.semiBoldRoboto12,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message),
                      ));
                    }
                    if (state is LoginSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Login Success'),
                      ));
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
                const SizedBox(
                  height: 24,
                ),
                const OrDividerWidget(),
                const SizedBox(
                  height: 12,
                ),
                SocialAuthButton(
                  onPressed: () {
                    context.read<AuthCubit>().signInWithGoogle();
                  },
                  image: Assets.assetsImagesGoogle,
                  text: 'Continue with Google',
                ),
                const SizedBox(
                  height: 12,
                ),
                SocialAuthButton(
                  onPressed: () {
                    // context.read<AuthCubit>().signInWithApple();
                  },
                  image: Assets.assetsImagesApple,
                  text: 'Continue with Apple',
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: Text.rich(TextSpan(
                    text: 'Don\'t have an account ? ',
                    style: Styles.regularRoboto12,
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: Styles.semiBoldRoboto12.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterView(),
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
