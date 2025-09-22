import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/auth_vaildation.dart';
import 'package:his/core/helpers/nav_bar_visibility_provider.dart';
import 'package:his/core/helpers/platformFile_to_file.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/authentication/presentation/view/widgets/authentication_text_form_field.dart';
import 'package:his/features/authentication/presentation/view/widgets/select_country_menu.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<RegisterViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  DateTime? datePicked;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    height: 37.h,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 320.w),
                    child: GradientText('Don\'t have an account , Create Now !',
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
                    constraints: BoxConstraints(maxWidth: 300.w),
                    child: Text(
                      'Access personalized care and medical updates in one place. ',
                      style: Styles.regularPoppins12
                          .copyWith(color: AppColors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        final imagefile =
                            await selectFile(type: FileType.image);
                        if (imagefile == null) return;
                        context.read<AuthCubit>().profileImage =
                            platformFileToFile(imagefile);
                      },
                      child: context.read<AuthCubit>().profileImage == null
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 36.r,
                                  backgroundColor: AppColors.primaryColor,
                                  child: CircleAvatar(
                                    radius: 35.r,
                                    backgroundColor: const Color(0xffDBEEF2),
                                    child: const Icon(Icons.person,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                                Positioned(
                                  bottom: -5.h,
                                  right: 0,
                                  left: 0,
                                  child: CircleAvatar(
                                    radius: 9.r,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 7.r,
                                      backgroundColor: AppColors.primaryColor,
                                      child: const Icon(
                                        Icons.edit,
                                        size: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : CircleAvatar(
                              radius: 35.r,
                              backgroundImage: FileImage(
                                File(context
                                        .read<AuthCubit>()
                                        .profileImage
                                        ?.path ??
                                    ''),
                              )),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text('Name', style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: context.read<AuthCubit>().nameController,
                    hintText: 'Name',
                    textInputType: TextInputType.name,
                    prefixIcon: SvgPicture.asset(
                      Assets.assetsImagesProfile,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Email Address', style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Please enter an email address';
                      } else if (!isValidEmail(email)) {
                        return 'Please enter a valid email address';
                      } else {
                        return null;
                      }
                    },
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
                  const Text('Phone Number', style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    controller: context.read<AuthCubit>().phoneController,
                    maxLength: 15,
                    validator: (phone) {
                      if (phone == null || phone.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!isValidPhoneNumber(phone)) {
                        return 'Please enter a valid phone number';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Phone Number',
                    textInputType: TextInputType.phone,
                    prefixIcon: SvgPicture.asset(
                      Assets.assetsImagesPhone,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Password', style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please enter a password';
                      } else {
                        return validatePassword(password);
                      }
                    },
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
                    ),
                    prefixIcon: SvgPicture.asset(
                      Assets.assetsImagesPassword,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Confirm Password',
                      style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (confirmPassword) {
                        if (confirmPassword == null ||
                            confirmPassword.isEmpty) {
                          return 'Please confirm your password';
                        } else {
                          if (confirmPassword ==
                              context
                                  .read<AuthCubit>()
                                  .passwordController
                                  .text) {
                            return null;
                          } else {
                            return 'Passwords do not match';
                          }
                        }
                      },
                      controller:
                          context.read<AuthCubit>().confirmPasswordController,
                      hintText: 'Confirm Password',
                      textInputType: TextInputType.visiblePassword,
                      obscureText: isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                        icon: isConfirmPasswordVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                size: 18,
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                size: 18,
                              ),
                      ),
                      prefixIcon: SvgPicture.asset(
                        Assets.assetsImagesPassword,
                      )),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Country of Practices',
                      style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  const SelectCountryMenu(
                    flag: true,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Academic Title', style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    isOptional: true,
                    controller: context.read<AuthCubit>().academicTitle,
                    hintText: 'Enter title',
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Job Description',
                      style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  AuthenticationTextFormField(
                    isOptional: true,
                    controller: context.read<AuthCubit>().jobDescription,
                    hintText: 'e.g., Senior researcher in .....',
                    textInputType: TextInputType.name,
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: const ShapeDecoration(
                          shape: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                  width: 1, color: AppColors.lightGrey))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Institution / University',
                                style: Styles.semiBoldPoppins12),
                            const SizedBox(
                              height: 4,
                            ),
                            AuthenticationTextFormField(
                              isOptional: true,
                              controller: context.read<AuthCubit>().institution,
                              hintText: 'e.g. Alexandria University',
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Text('Department',
                                style: Styles.semiBoldPoppins12),
                            const SizedBox(
                              height: 4,
                            ),
                            AuthenticationTextFormField(
                              isOptional: true,
                              controller: context.read<AuthCubit>().department,
                              hintText: 'e.g. Department of ....',
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Text('Year of Graduation',
                                style: Styles.semiBoldPoppins12),
                            const SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: () async {
                                datePicked =
                                    await DatePicker.showSimpleDatePicker(
                                  context,
                                  firstDate: DateTime(1950),
                                  initialDate: datePicked ?? DateTime.now(),
                                  lastDate: DateTime.now(),
                                  dateFormat: "dd-MMMM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                );

                                if (datePicked != null) {
                                  context.read<AuthCubit>().setYearOfGraduation(
                                        datePicked!,
                                      );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: const ShapeDecoration(
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: AppColors.lightGrey))),
                                child: Text(
                                  context
                                          .watch<AuthCubit>()
                                          .yearOfGraduation
                                          ?.year
                                          .toString() ??
                                      'YYYY',
                                  style: Styles.semiBoldPoppins12.copyWith(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Text('Country of Graduation',
                                style: Styles.semiBoldPoppins12),
                            const SizedBox(
                              height: 4,
                            ),
                            const SelectCountryMenu(
                              flag: false,
                            ),
                          ])),
                  const SizedBox(
                    height: 26,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterFailure) {
                        showCustomSnackBar(
                          message: state.message,
                          context: context,
                        );
                      }
                      if (state is LoginFailure) {
                        if (state.registerError?["email"] != null) {
                          showCustomSnackBar(
                            message: state.registerError?["email"],
                            context: context,
                          );
                        }
                        if (state.registerError?["phone"] != null) {
                          showCustomSnackBar(
                            message: state.registerError?["phone"],
                            context: context,
                          );
                        } else if (state.registerError == null) {
                          showCustomSnackBar(
                            message: state.message,
                            context: context,
                          );
                        }
                      }
                      if (state is RegisterSuccess) {
                        showCustomSnackBar(
                            message: state.registerSuccessModel.message ??
                                'Registered successfully',
                            context: context,
                            backgroundColor: const Color(0xFF0F8737));
                        // Navigator.pop(context);
                        Prefs.setBool(PrefsKeys.isLoggedIn, true);

                        Provider.of<NavBarVisibilityProvider>(context,
                                listen: false)
                            .show();
                        Navigator.pushReplacementNamed(
                          context,
                          MainView.routeName,
                        );
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
                      return state is RegisterLoading || state is LoginLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ))
                          : CustomTextButton(
                              text: 'Register',
                              onPressed: () async {
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
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account ? ',
                        style: Styles.regularPoppins12,
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: Styles.semiBoldPoppins12.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          const LoginView(),
                                      transitionsBuilder: (context, animation,
                                              secondaryAnimation, child) =>
                                          FadeTransition(
                                              opacity: animation, child: child),
                                    ));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 37.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future selectFile(
      {required FileType type, List<String>? allowedExtensions}) async {
    if (!mounted) return null;

    try {
      if (mounted) setState(() {});

      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
      );
      if (!mounted) return null;

      if (result == null) return null;
      if (mounted) setState(() {});
      return result.files.first;
    } on PlatformException catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.message ?? 'Something went wrong');
      }
      return null;
    } finally {}
  }
}
