import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

AppBar buildAppBar(BuildContext context,
    {required String title,
    bool showBackButton = true,
    bool centerTitle = true}) {
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
  );
}
