import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: Styles.semiBoldRoboto20,
    ),
  );
}
