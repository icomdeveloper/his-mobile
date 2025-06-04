import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isSearch = true,
    this.maxLines = 1,
  });
  final String hintText;
  final bool isSearch;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
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
          hintStyle:
              Styles.regularRoboto12.copyWith(color: const Color(0xff999999)),
        ));
  }

/*************  ✨ Windsurf Command ⭐  *************/
  /// Creates a border with a specified color and default styling.
  ///
  /// If [color] is provided, it will be used for the border's color.
  /// Otherwise, it defaults to [AppColors.lightGrey].
  /// The border has a fixed width of 1 and a circular radius of 14.

  /// *****  7ce90289-ffa4-4208-abf5-30d07294eb95  ******
  OutlineInputBorder buildBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(width: 1, color: color ?? AppColors.lightGrey));
  }
}
