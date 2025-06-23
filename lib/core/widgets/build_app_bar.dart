import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

AppBar buildAppBar(BuildContext context,
    {required String title,
    bool showBackButton = true,
    bool centerTitle = true,
    bool isEditAppear = false}) {
  log('isEditAppear From Appbar ==>$isEditAppear');
  return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.grey,
                size: 18,
              ),
            )
          : null,
      title: Text(
        title,
        style: Styles.semiBoldRoboto20,
      ),
      centerTitle: centerTitle,
      actions: isEditAppear
          ? [
              const SizedBox(width: 16),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(Assets.assetsImagesEdit),
              ),
              const SizedBox(width: 24),
            ]
          : const [SizedBox.shrink()]);
}
