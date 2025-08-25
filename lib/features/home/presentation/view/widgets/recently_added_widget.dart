import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/format_duration.dart';
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
    final text = mediaModel.description ?? '';
    final isHtml = text.contains(RegExp(r'<[a-z][\s\S]*>'));
    return Column(
      children: [
        InkWell(
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
                  pageBuilder: (_, __, ___) => VideoView(
                    mediaModel: mediaModel,
                    // likesCount: mediaModel.likesCount ?? 0,
                  ),
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
          child: Row(
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
                              imageUrl: mediaModel.thumbnailPath!,
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
                              formatDuration(mediaModel.duration ?? ""),
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
                      maxLines: 2,
                      style: Styles.semiBoldPoppins14,
                    ),
                    isHtml
                        ? Transform.translate(
                            offset: Offset(-6.w, -4),
                            child: Html(
                                data: mediaModel.description?.trim() ?? '',
                                style: {
                                  "p": Style(
                                      padding: HtmlPaddings.zero,
                                      margin: Margins.zero,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      color: AppColors.grey,
                                      fontSize: FontSize(12),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')
                                }),
                          )
                        : Text(
                            mediaModel.description ?? "",
                            style: Styles.regularPoppins12.copyWith(
                              color: AppColors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                    const SizedBox(height: 4),
                    mediaModel.createdAt != null
                        ? Text(
                            '${formatDateWithoutTime(mediaModel.createdAt!)} , ${mediaModel.views} Views ',
                            style: Styles.semiBoldPoppins12.copyWith(
                              color: const Color(0xff999999),
                            ),
                          )
                        : const Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        const Divider(color: Color(0xFFEEEEEE), thickness: 2),
      ],
    );
  }
}
