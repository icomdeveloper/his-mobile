import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.textInputType,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
  });
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 12.w,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child:
                        prefixIcon ?? SvgPicture.asset(Assets.assetsImagesLogo),
                  ),
                ),
                Transform.rotate(
                    angle: 90 * 3.14 / 180, child: const Icon(Icons.remove)),
              ],
            ),
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: buildBorder(),
          border: buildBorder(),
          focusedBorder: buildBorder(),
          hintStyle: Styles.regularRoboto12,
          hintText: hintText),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(width: 1, color: Color(0xffEDEDED)));
  }
}
