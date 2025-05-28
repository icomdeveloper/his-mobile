import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:his/features/authentication/presentation/view/widgets/custom_text_form_field.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<RegisterViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name',
                    style: Styles.semiBoldPoppins14,
                  ),
                  CustomTextFormField(
                    controller: context.read<RegisterCubit>().nameController,
                    hintText: 'Name',
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Username',
                    style: Styles.semiBoldPoppins14,
                  ),
                  CustomTextFormField(
                    controller:
                        context.read<RegisterCubit>().usernameController,
                    hintText: 'UserName',
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Email',
                    style: Styles.semiBoldPoppins14,
                  ),
                  CustomTextFormField(
                    controller: context.read<RegisterCubit>().emailController,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'password',
                    style: Styles.semiBoldPoppins14,
                  ),
                  CustomTextFormField(
                    controller:
                        context.read<RegisterCubit>().passwordController,
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Confirm Password',
                    style: Styles.semiBoldPoppins14,
                  ),
                  CustomTextFormField(
                    controller:
                        context.read<RegisterCubit>().confirmPasswordController,
                    hintText: 'Confirm Password',
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Phone Number',
                    style: Styles.semiBoldPoppins14,
                  ),
                  CustomTextFormField(
                    controller: context.read<RegisterCubit>().phoneController,
                    hintText: 'Phone Number',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  BlocConsumer<RegisterCubit, RegisterState>(
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
                                  context.read<RegisterCubit>().register();
                                } else {
                                  autovalidateMode = AutovalidateMode.always;
                                  setState(() {});
                                }
                              },
                            );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: Styles.mediumRoboto12,
                        children: [
                          TextSpan(
                            text: 'login Now',
                            style: Styles.mediumRoboto12.copyWith(
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
