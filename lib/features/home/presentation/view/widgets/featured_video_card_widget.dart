import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class FeaturedVideoCardWidget extends StatelessWidget {
  const FeaturedVideoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Stack(children: [
        Image.asset(
          Assets.assetsImagesDoctestimage,
          fit: BoxFit.fill,
        ),
        const Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          top: 0,
          child: Center(
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  )),
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: SvgPicture.asset(
            Assets.assetsImagesBookmarked,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
        ),
        Positioned(
          right: 12,
          bottom: 12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                '10:14',
                style: Styles.regularRoboto12.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
