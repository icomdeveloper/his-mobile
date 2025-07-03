import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';

import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, title: 'Edit Profile'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name', style: Styles.semiBoldPoppins14),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isSearch: false,
                  hintText: getUserData().userInfo?.name ?? '',
                  controller: context.read<EditProfileCubit>().nameController,
                ),
                // const SizedBox(
                //   height: 14,
                // ),
                // const Text('Email Address', style: Styles.semiBoldPoppins14),
                // const SizedBox(
                //   height: 4,
                // ),
                // CustomTextField(
                //   isSearch: false,
                //   hintText: getUserData().userInfo?.email ?? '',
                // ),
                const SizedBox(
                  height: 14,
                ),
                const Text('Phone Number', style: Styles.semiBoldPoppins14),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  isSearch: false,
                  hintText: getUserData().userInfo?.phone ?? '',
                  controller: context.read<EditProfileCubit>().phoneController,
                ),
                SizedBox(
                  height: 26.h,
                ),
                BlocConsumer<EditProfileCubit, EditProfileState>(
                  listener: (context, state) {
                    if (state is EditProfileSuccess) {
                      showCustomSnackBar(
                          message: 'Profile Updated',
                          context: context,
                          backgroundColor: const Color(0xFF0F8737));
                      updateUserData(phone: state.phone, name: state.name);
                      Navigator.pop(context);
                    }
                    if (state is EditProfileFailure) {
                      showCustomSnackBar(
                        message: state.errMessage,
                        context: context,
                      );
                    }
                  },
                  builder: (context, state) => state is EditProfileLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomTextButton(
                          text: 'Confirm',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context.read<EditProfileCubit>().editProfile();
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
