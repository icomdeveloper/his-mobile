import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:his/core/helpers/auth_vaildation.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/presentation/view/widgets/select_country_menu.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/presentation/cubits/get_user_info_cubit/get_user_info_cubit.dart';

import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  DateTime? datePicked;
  @override
  initState() {
    super.initState();
    context.read<EditProfileCubit>().nameController.text =
        getUserData().userInfo?.name ?? '';

    context.read<EditProfileCubit>().phoneController.text =
        getUserData().userInfo?.phone ?? '';

    context.read<EditProfileCubit>().countryOfPractice.text =
        getUserData().userInfo?.countryOfPractices ?? '';

    context.read<EditProfileCubit>().yearOfGraduation =
        getUserData().userInfo?.yearOfGraduation;

    context.read<EditProfileCubit>().jobDescription.text =
        getUserData().userInfo?.jobDescription ?? '';

    context.read<EditProfileCubit>().academicTitle.text =
        getUserData().userInfo?.academicTitle ?? '';

    context.read<EditProfileCubit>().institution.text =
        getUserData().userInfo?.institution ?? '';

    context.read<EditProfileCubit>().department.text =
        getUserData().userInfo?.department ?? '';

    context.read<EditProfileCubit>().countryOfGraduation.text =
        getUserData().userInfo?.countryOfGraduation ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(
          context,
          title: 'Edit Profile',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
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
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Please enter your current or new name';
                      } else {
                        return null;
                      }
                    },
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
                    validator: (phone) {
                      if (phone == null || phone.isEmpty) {
                        return 'Please enter your current or new phone number';
                      } else if (!isValidPhoneNumber(phone)) {
                        return 'Please enter a valid phone number';
                      } else {
                        return null;
                      }
                    },
                    controller:
                        context.read<EditProfileCubit>().phoneController,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Country of Practices',
                      style: Styles.semiBoldPoppins12),

                  const SizedBox(
                    height: 4,
                  ),
                  SelectCountryMenu(
                    flag: true,
                    isFromRegister: false,
                    countrySelectedBefore:
                        context.read<EditProfileCubit>().countryOfPractice.text,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Academic Title', style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextField(
                    isSearch: false,
                    controller: context.read<EditProfileCubit>().academicTitle,
                    hintText: 'Enter title',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text('Job Description',
                      style: Styles.semiBoldPoppins12),
                  const SizedBox(
                    height: 4,
                  ),
                  CustomTextField(
                    isSearch: false,
                    controller: context.read<EditProfileCubit>().jobDescription,
                    hintText: 'e.g., Senior researcher in .....',
                    keyboardType: TextInputType.name,
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
                            CustomTextField(
                              isSearch: false,
                              controller:
                                  context.read<EditProfileCubit>().institution,
                              hintText: 'e.g. Alexandria University',
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Text('Department',
                                style: Styles.semiBoldPoppins12),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTextField(
                              isSearch: false,
                              controller:
                                  context.read<EditProfileCubit>().department,
                              hintText: 'e.g. Department of ....',
                              keyboardType: TextInputType.name,
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
                                  log(datePicked.toString().split(' ')[0]);
                                  context
                                          .read<EditProfileCubit>()
                                          .yearOfGraduation =
                                      datePicked!.toString().split(' ')[0];
                                  setState(() {});
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
                                child: context
                                            .read<EditProfileCubit>()
                                            .yearOfGraduation ==
                                        null
                                    ? Text(
                                        'YYYY',
                                        style:
                                            Styles.semiBoldPoppins12.copyWith(
                                          color: AppColors.grey,
                                        ),
                                      )
                                    : Text(
                                        context
                                            .read<EditProfileCubit>()
                                            .yearOfGraduation!,
                                        style: Styles.semiBoldPoppins12),
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
                            SelectCountryMenu(
                              flag: false,
                              isFromRegister: false,
                              countrySelectedBefore: context
                                  .read<EditProfileCubit>()
                                  .countryOfGraduation
                                  .text,
                            ),
                          ])),
                  const SizedBox(
                    height: 26,
                  ),

                  BlocConsumer<EditProfileCubit, EditProfileState>(
                    listener: (context, state) async {
                      if (state is EditProfileSuccess) {
                        await context.read<GetUserInfoCubit>().getUserInfo();
                        showCustomSnackBar(
                            message: 'Profile Updated',
                            context: context,
                            backgroundColor: const Color(0xFF0F8737));

                        Navigator.pop(context, 'refresh');
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
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
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
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
