import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class LikesAndCommentsWidget extends StatelessWidget {
  const LikesAndCommentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SvgPicture.asset(Assets.assetsImagesFavourite),
      const SizedBox(
        width: 4,
      ),
      Text(
        '192 Like',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
      const SizedBox(
        width: 24,
      ),
      SvgPicture.asset(Assets.assetsImagesComment),
      const SizedBox(
        width: 4,
      ),
      Text(
        '46 Comments',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
    ]);
  }
}
