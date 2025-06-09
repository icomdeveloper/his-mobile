import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundImage: const NetworkImage('https://i.pravatar.cc/300?img=1'),
        radius: 20.r,
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Mustafa Kamel',
            style: Styles.semiBoldRoboto12,
          ),
          Text('3 Minutes ago', style: Styles.regularRoboto12)
        ],
      ),
      subtitle: Column(
        children: [
          const Text(
            'Lorem ipsum dolor sit amet consectetur. Neque dolor nulla sit non feugiat dictumst cras condimentum dignissim.',
            style: Styles.regularRoboto12,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SvgPicture.asset(Assets.assetsImagesReply),
              const SizedBox(
                width: 8,
              ),
              const Text(
                'Reply',
                style: Styles.regularRoboto12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
