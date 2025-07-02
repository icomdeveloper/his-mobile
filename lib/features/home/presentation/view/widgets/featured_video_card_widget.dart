import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/format_duration.dart';
import 'package:his/core/helpers/likes_manager.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/video_view.dart';

class FeaturedVideoCardWidget extends StatefulWidget {
  const FeaturedVideoCardWidget({super.key, required this.mediaModel});
  final MediaModel mediaModel;
  @override
  State<FeaturedVideoCardWidget> createState() =>
      _FeaturedVideoCardWidgetState();
}

class _FeaturedVideoCardWidgetState extends State<FeaturedVideoCardWidget> {
  bool isBookmark = false;
  @override
  void initState() {
    _loadBookmarkStatus();
    super.initState();
  }

  Future<void> _loadBookmarkStatus() async {
    final isbookmarked =
        await LikesManager.isLiked(widget.mediaModel.id!, PrefsKeys.bookmarks);
    setState(() {
      isBookmark = isbookmarked;
    });
  }

  Future<void> _toggleBookmark() async {
    await LikesManager.toggleLike(widget.mediaModel.id!, PrefsKeys.bookmarks);
    setState(() {
      isBookmark = !isBookmark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Stack(children: [
        SizedBox(
          height: 192.h,
          child: AspectRatio(
            aspectRatio: 342 / 192,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.mediaModel.thumbnailPath!,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                    pageBuilder: (_, __, ___) => VideoView(
                      mediaModel: widget.mediaModel,
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
              if (!isBookmark) {
                context
                    .read<BookmarksCubit>()
                    .addToBookmarks(mediaId: widget.mediaModel.id);
              } else {
                context
                    .read<BookmarksCubit>()
                    .removeFromBookmarks(mediaId: widget.mediaModel.id);
              }
              _toggleBookmark();
            },
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 11.w,
                child: AspectRatio(
                  aspectRatio: 11 / 14,
                  child: SvgPicture.asset(
                    isBookmark
                        ? Assets.assetsImagesBookmarkedFilled
                        : Assets.assetsImagesBookmarked,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
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
                formatDuration(widget.mediaModel.duration ?? ''),
                style: Styles.regularRoboto12.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
