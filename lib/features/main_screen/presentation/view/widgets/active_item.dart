import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/main_screen/data/model/nav_bar_model.dart';

import '../../../../../core/utils/app_colors.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.navBarModel});
  final NavBarModel navBarModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          navBarModel.image,
          colorFilter:
              const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
        ),
        Text(
          navBarModel.title,
          style: Styles.mediumRoboto12.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        Container(
          height: 2.h,
          width: 46..w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: AppColors.primaryColor,
          ),
        )
      ],
    );
  }
}
