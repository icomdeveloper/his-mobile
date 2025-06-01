import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 1,
            color: Color(0xffEDEDED),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'Or',
            style: Styles.regularRoboto12.copyWith(color: AppColors.grey),
          ),
        ),
        const Expanded(
          child: Divider(
            height: 1,
            color: Color(0xffEDEDED),
          ),
        ),
      ],
    );
  }
}
