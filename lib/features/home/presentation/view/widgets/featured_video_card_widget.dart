import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/home/presentation/view/video_view.dart';

class FeaturedVideoCardWidget extends StatefulWidget {
  const FeaturedVideoCardWidget({super.key});

  @override
  State<FeaturedVideoCardWidget> createState() =>
      _FeaturedVideoCardWidgetState();
}

class _FeaturedVideoCardWidgetState extends State<FeaturedVideoCardWidget> {
  bool isBookmarked = false;
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
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              if (!Prefs.getBool(PrefsKeys.isLoggedIn)) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const LoginView(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const VideoView(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              }
            },
            child: const Center(
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
        ),
        Positioned(
          right: 12,
          top: 12,
          child: InkWell(
            onTap: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
            },
            child: SvgPicture.asset(
              isBookmarked
                  ? Assets.assetsImagesBookmarkedFilled
                  : Assets.assetsImagesBookmarked,
              colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor, BlendMode.srcIn),
            ),
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
