import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';

showCustomSnackBar(
    {required String message,
    required BuildContext context,
    Color backgroundColor = const Color(0xffBB1313)}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 16,
    ),
    backgroundColor: backgroundColor,
    content: Text(
      message,
      style: Styles.regularPoppins12,
    ),
  ));
}
