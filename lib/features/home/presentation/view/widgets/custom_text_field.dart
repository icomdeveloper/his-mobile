import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      enabledBorder: buildBorder(),
      border: buildBorder(),
      focusedBorder: buildBorder(),
      prefixIcon: SizedBox(
        height: 15,
        width: 15,
        child: Center(
          child: SvgPicture.asset(
            Assets.assetsImagesSearch,
          ),
        ),
      ),
      hintText: 'Search..',
      hintStyle:
          Styles.regularRoboto12.copyWith(color: const Color(0xff999999)),
    ));
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(width: 1, color: Color(0xffEDEDED)));
  }
}
