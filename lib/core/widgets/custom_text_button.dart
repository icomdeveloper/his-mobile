import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isArrowAppear = true,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.black12,
  });
  final String text;
  final void Function()? onPressed;
  final bool isArrowAppear;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: double.infinity,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            // shadowColor: const Color(0xFF6C7278),
            elevation: 3,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: borderColor, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: Styles.mediumRoboto14.copyWith(color: textColor),
              ),
              const SizedBox(width: 13),
              isArrowAppear
                  ? SvgPicture.asset(
                      Assets.assetsImagesArrowForward,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    )
                  : const SizedBox.shrink(),
            ],
          )),
    );
  }
}
