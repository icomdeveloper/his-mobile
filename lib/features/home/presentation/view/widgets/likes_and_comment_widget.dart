import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class LikesAndCommentsWidget extends StatelessWidget {
  const LikesAndCommentsWidget({
    super.key,
    required this.numberOfLikes,
    required this.numberOfComments,
  });
  final int numberOfLikes, numberOfComments;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          // setState(() {
          //   isLiked = !isLiked;
          //   if (isLiked) {
          //     numOfLikes++;
          //   } else {
          //     numOfLikes--;
          //   }
          // });
        },
        child: const Icon(
          Icons.favorite_border_outlined,
          size: 18,
          color: AppColors.darkGrey,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        '$numberOfLikes Like',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
      const SizedBox(
        width: 24,
      ),
      SvgPicture.asset(Assets.assetsImagesComment),
      const SizedBox(
        width: 4,
      ),
      Text(
        '$numberOfComments Comments',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
    ]);
  }
}
