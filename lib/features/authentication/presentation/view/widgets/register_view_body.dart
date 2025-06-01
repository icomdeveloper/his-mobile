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
import 'package:his/features/authentication/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/authentication/presentation/view/widgets/or_divider_widget.dart';
import 'package:his/features/authentication/presentation/view/widgets/social_auth_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<RegisterViewBody> {
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
                  GradientText('Don\'t have an account , Create Now !',
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
                    child: Text(
                      'Access personalized care and medical updates in one place. ',
                      style: Styles.regularRoboto12
                          .copyWith(color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text('Username', style: Styles.semiBoldRoboto12),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextFormField(
                    controller: context.read<AuthCubit>().usernameController,
                    hintText: 'Username',
                    textInputType: TextInputType.name,
                    prefixIcon: SvgPicture.asset(
                      Assets.assetsImagesProfile,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Email Address', style: Styles.semiBoldRoboto12),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextFormField(
                    controller: context.read<AuthCubit>().emailController,
                    hintText: 'Email Address',
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: SvgPicture.asset(
                      Assets.assetsImagesMail,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Phone Number', style: Styles.semiBoldRoboto12),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextFormField(
                      controller: context.read<AuthCubit>().phoneController,
                      hintText: 'Phone Number',
                      textInputType: TextInputType.phone,
                      prefixIcon: SvgPicture.asset(
                        Assets.assetsImagesPhone,
                      )),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // const Text(
                  //   'password',
                  //   style: Styles.semiBoldPoppins14,
                  // ),
                  // CustomTextFormField(
                  //   controller:
                  //       context.read<AuthCubit>().passwordController,
                  //   hintText: 'Password',
                  //   textInputType: TextInputType.visiblePassword,
                  //   obscureText: isPasswordVisible,
                  //   suffixIcon: IconButton(
                  //     icon: Icon(
                  //       isPasswordVisible
                  //           ? Icons.visibility
                  //           : Icons.visibility_off,
                  //     ),
                  //     onPressed: () {
                  //       setState(() {
                  //         isPasswordVisible = !isPasswordVisible;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // const Text(
                  //   'Confirm Password',
                  //   style: Styles.semiBoldPoppins14,
                  // ),
                  // CustomTextFormField(
                  //   controller:
                  //       context.read<AuthCubit>().confirmPasswordController,
                  //   hintText: 'Confirm Password',
                  //   textInputType: TextInputType.visiblePassword,
                  //   obscureText: isPasswordVisible,
                  //   suffixIcon: IconButton(
                  //     icon: Icon(
                  //       isPasswordVisible
                  //           ? Icons.visibility
                  //           : Icons.visibility_off,
                  //     ),
                  //     onPressed: () {
                  //       setState(() {
                  //         isPasswordVisible = !isPasswordVisible;
                  //       });
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  // const Text(
                  //   'Phone Number',
                  //   style: Styles.semiBoldPoppins14,
                  // ),
                  // CustomTextFormField(
                  //   controller: context.read<AuthCubit>().phoneController,
                  //   hintText: 'Phone Number',
                  //   textInputType: TextInputType.number,
                  // ),
                  const SizedBox(
                    height: 26,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.message),
                        ));
                      }
                      if (state is RegisterSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(state.registerSuccessModel.success),
                        ));
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return state is RegisterLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomTextButton(
                              text: 'Register',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  context.read<AuthCubit>().register();
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
                      // context.read<AuthCubit>().signInWithGoogle();
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
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account ? ',
                        style: Styles.regularRoboto12,
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: Styles.semiBoldRoboto12.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
