import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class TextContainerWidget extends StatelessWidget {
  const TextContainerWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.lightPrimaryColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: Styles.regularPoppins12
            .copyWith(color: AppColors.primaryColor, fontSize: 10.sp),
      ),
    );
  }
}
