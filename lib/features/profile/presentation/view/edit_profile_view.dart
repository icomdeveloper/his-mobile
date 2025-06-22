import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, title: 'Edit Profile'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username', style: Styles.semiBoldPoppins14),
              const SizedBox(
                height: 4,
              ),
              CustomTextField(
                isSearch: false,
                hintText: getUserData().userInfo?.username ?? '',
              ),
              const SizedBox(
                height: 14,
              ),
              const Text('Email Address', style: Styles.semiBoldPoppins14),
              const SizedBox(
                height: 4,
              ),
              CustomTextField(
                isSearch: false,
                hintText: getUserData().userInfo?.email ?? '',
              ),
              const SizedBox(
                height: 14,
              ),
              const Text('Phone Number', style: Styles.semiBoldPoppins14),
              const SizedBox(
                height: 4,
              ),
              CustomTextField(
                isSearch: false,
                hintText: getUserData().userInfo?.phone ?? '',
              ),
              SizedBox(
                height: 26.h,
              ),
              CustomTextButton(
                text: 'Confirm',
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
