import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:his/features/home/presentation/view/video_view.dart';

class RecentlyAddedWidget extends StatelessWidget {
  const RecentlyAddedWidget({
    super.key,
    required this.mediaModel,
  });
  final MediaModel mediaModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              pageBuilder: (_, __, ___) => VideoView(mediaModel: mediaModel),
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
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.33,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: mediaModel.thumbnailPath ?? '',
                              fit: BoxFit.cover,
                            )),
                      ),
                      Positioned(
                        right: 8.w,
                        bottom: 8.h,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 7),
                            child: Text(
                              mediaModel.duration?.substring(0, 1) ?? "",
                              style: Styles.regularRoboto8
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * 0.4) -
                      32 -
                      10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mediaModel.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: Styles.semiBoldPoppins14,
                    ),
                    Text(
                      mediaModel.description ?? "",
                      style: Styles.regularRoboto12.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${mediaModel.createdAt!.day}/${mediaModel.createdAt!.month}/${mediaModel.createdAt!.year} , 9.2K Views ',
                      style: Styles.semiBoldRoboto12.copyWith(
                        color: const Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: Color(0xFFEEEEEE), thickness: 2),
        ],
      ),
    );
  }
}
