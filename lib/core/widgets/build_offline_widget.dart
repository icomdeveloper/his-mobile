import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

Widget buildOfflineWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(Assets.assetsImagesIcons8NoInternet64),
      const Text(
        'Oops!!.. Your internet connection seems to be offline',
        style: Styles.semiBoldPoppins14,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
