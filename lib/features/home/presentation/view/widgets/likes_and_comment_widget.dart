import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class LikesAndCommentsWidget extends StatefulWidget {
  const LikesAndCommentsWidget({
    super.key,
  });

  @override
  State<LikesAndCommentsWidget> createState() => _LikesAndCommentsWidgetState();
}

class _LikesAndCommentsWidgetState extends State<LikesAndCommentsWidget> {
  bool isLiked = false;
  int numOfLikes = 192;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          setState(() {
            isLiked = !isLiked;
            if (isLiked) {
              numOfLikes++;
            } else {
              numOfLikes--;
            }
          });
        },
        child: isLiked
            ? const Icon(
                Icons.favorite,
                size: 18,
                color: AppColors.primaryColor,
              )
            : const Icon(
                Icons.favorite_border_outlined,
                size: 18,
                color: AppColors.darkGrey,
              ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        '$numOfLikes Like',
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
        '46 Comments',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
    ]);
  }
}
