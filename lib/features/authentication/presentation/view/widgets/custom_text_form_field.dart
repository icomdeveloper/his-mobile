import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.textInputType,
    required this.controller,
  });
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This Field is required';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: buildBorder(),
          border: buildBorder(),
          focusedBorder: buildBorder(),
          hintStyle: Styles.regularRoboto12,
          hintText: hintText),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(width: 1, color: Color(0xffEDEDED)));
  }
}
