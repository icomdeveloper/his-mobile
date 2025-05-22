import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: const NetworkImage('https://i.pravatar.cc/300?img=1'),
        radius: 20.r,
      ),
      SizedBox(width: 12.w),
      Container(
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 48 - 12.w - 20.r * 2),
        decoration: ShapeDecoration(
            color: const Color(0xffF7F7F7),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: Column(children: [
          Row(
            children: [
              const Text(
                'Mustafa Kamel',
                style: Styles.semiBoldRoboto12,
              ),
              const SizedBox(
                width: 12,
              ),
              CircleAvatar(
                radius: 4.r,
                backgroundColor: AppColors.primaryColor,
              ),
            ],
          ),
          Text(
            'Lorem ipsum dolor sit amet consectetur. Sed cursus purus.',
            style: Styles.regularRoboto12.copyWith(color: AppColors.grey),
          ),
        ]),
      ),
    ]);
  }
}
