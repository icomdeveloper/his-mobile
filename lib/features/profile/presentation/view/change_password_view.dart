import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/authentication/presentation/view/widgets/custom_text_form_field.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'Change Password'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Current Password', style: Styles.semiBoldPoppins14),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  prefixIcon: SvgPicture.asset(
                    Assets.assetsImagesPassword,
                  ),
                  hintText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'New Password',
                  style: Styles.semiBoldPoppins14,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  prefixIcon: SvgPicture.asset(Assets.assetsImagesPassword),
                  hintText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'Confirm Password',
                  style: Styles.semiBoldPoppins14,
                ),
                const SizedBox(
                  height: 4,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  prefixIcon: SvgPicture.asset(Assets.assetsImagesPassword),
                  hintText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 41,
                ),
                CustomTextButton(text: 'Update Password', onPressed: () {}),
              ]),
        ),
      ),
    );
  }
}
