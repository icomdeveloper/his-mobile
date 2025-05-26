import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({
    super.key,
    required this.data,
    required this.title,
  });
  final String data;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.semiBoldRoboto12,
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xffEDEDED), width: 1),
            ),
          ),
          child: Text(
            data,
            style: Styles.regularRoboto12.copyWith(color: AppColors.grey),
          ),
        ),
      ],
    );
  }
}
