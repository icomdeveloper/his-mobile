import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField(
      {super.key,
      required this.controller,
      this.onTap,
      this.autofocus = false,
      this.onSubmitted});
  final TextEditingController controller;
  final void Function()? onTap;
  final bool autofocus;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Styles.regularPoppins14,
      autofocus: autofocus,
      onSubmitted: onSubmitted,
      controller: controller,
      decoration: InputDecoration(
          fillColor: const Color(0xffF7F7F7),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          enabledBorder: buildBorder(),
          border: buildBorder(),
          focusedBorder: buildBorder(),
          prefixIcon: SizedBox(
            height: 15,
            width: 15,
            child: Center(
                child: CircleAvatar(
              backgroundColor: AppColors.grey,
              radius: 12.r,
              child: const Icon(
                Icons.more_horiz_outlined,
                size: 18,
                color: Color(0xffDADADA),
              ),
            )),
          ),
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: SizedBox(
              height: 15,
              width: 15,
              child: Center(
                  child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 14.r,
                child: SvgPicture.asset(Assets.assetsImagesSend),
              )),
            ),
          ),
          hintText: 'Write your message',
          hintStyle: Styles.regularPoppins12.copyWith(color: AppColors.grey)),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(38)),
        borderSide: BorderSide(width: 1, color: AppColors.lightGrey));
  }
}
