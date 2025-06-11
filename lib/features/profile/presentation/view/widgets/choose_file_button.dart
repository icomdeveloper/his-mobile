import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class ChooseFileButton extends StatelessWidget {
  const ChooseFileButton({
    super.key,
    this.onTapped,
  });
  final void Function()? onTapped;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
      child: ElevatedButton(
        onPressed: onTapped,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Choose File',
          style: Styles.regularRoboto10.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
