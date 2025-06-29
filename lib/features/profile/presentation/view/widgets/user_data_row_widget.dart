import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class UserDataRowWidget extends StatelessWidget {
  const UserDataRowWidget({
    super.key,
    required this.title,
    required this.image,
    this.trailing,
    this.onTap,
  });
  final String title;
  final String image;
  final Widget? trailing;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(12),
            decoration: const ShapeDecoration(
              color: AppColors.lightPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: SizedBox(
              width: 18,
              child: AspectRatio(
                aspectRatio: 1,
                child: SvgPicture.asset(
                  image,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            )),
        SizedBox(width: 12.w),
        Text(title, style: Styles.regularPoppins16),
        const Spacer(),
        trailing ?? const SizedBox.shrink(),
      ]),
    );
  }
}
