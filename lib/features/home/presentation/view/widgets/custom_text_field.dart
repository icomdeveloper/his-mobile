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
          focusedBorder: buildBorder(),
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

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(width: 1, color: AppColors.lightGrey));
  }
}
