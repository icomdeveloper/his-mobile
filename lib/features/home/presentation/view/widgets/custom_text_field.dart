import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.isSearch = true,
      this.maxLines = 1,
      this.readOnly = false,
      this.suffixIcon,
      this.controller});
  final String hintText;
  final bool isSearch;
  final int maxLines;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field is required';
          }
          return null;
        },
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          enabledBorder: buildBorder(),
          border: buildBorder(),
          focusedBorder: buildBorder(color: AppColors.primaryColor),
          prefixIcon: isSearch
              ? SizedBox(
                  height: 15,
                  width: 15,
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.assetsImagesSearch,
                    ),
                  ),
                )
              : null,
          hintText: hintText,
          hintStyle: Styles.regularRoboto12.copyWith(color: AppColors.grey),
          suffixIcon: suffixIcon,
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 50, maxWidth: 100),
        ));
  }

  OutlineInputBorder buildBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(width: 1, color: color ?? AppColors.lightGrey));
  }
}
