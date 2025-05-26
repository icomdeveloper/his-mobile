import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';

class RecommendedVideoCardWidget extends StatelessWidget {
  const RecommendedVideoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165.w,
      child: AspectRatio(
        aspectRatio: 165 / 112,
        child: Container(
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Stack(children: [
            AspectRatio(
              aspectRatio: 165 / 112,
              child: Image.asset(
                Assets.assetsImagesDoctestimage,
                fit: BoxFit.fill,
              ),
            ),
            const Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: 0,
              child: Center(
                child: CircleAvatar(
                    radius: 21,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: SvgPicture.asset(
                Assets.assetsImagesBookmarked,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    '10:14',
                    style: Styles.regularRoboto8.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
