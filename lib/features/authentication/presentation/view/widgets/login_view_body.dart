import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/authentication/presentation/cubits/cubit/login_cubit.dart';
import 'package:his/features/authentication/presentation/view/widgets/custom_text_form_field.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
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
                  'UserName',
                  style: Styles.semiBoldPoppins14,
                ),
                CustomTextFormField(
                  controller: context.read<LoginCubit>().usernameController,
                  hintText: 'UserName',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'password',
                  style: Styles.semiBoldPoppins14,
                ),
                CustomTextFormField(
                  controller: context.read<LoginCubit>().passwordController,
                  hintText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 60,
                ),
                BlocConsumer<LoginCubit, LoginState>(
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
                    }
                  },
                  builder: (context, state) {
                    return state is LoginLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomTextButton(
                            text: 'Login',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                context.read<LoginCubit>().login();
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
