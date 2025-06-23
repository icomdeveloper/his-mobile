import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/convert_drive_files.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/video_view.dart';
import 'package:his/features/home/presentation/view/widgets/likes_and_comment_widget.dart';

class VideoCardWidget extends StatefulWidget {
  const VideoCardWidget({
    super.key,
    this.isDescriptionAppeared = true,
    this.topRightIcon,
    this.onIconTap,
    this.isbookmark = false,
    required this.mediaModel,
  });
  final bool isDescriptionAppeared;
  final Widget? topRightIcon;
  final void Function()? onIconTap;
  final bool isbookmark;
  final MediaModel mediaModel;

  @override
  State<VideoCardWidget> createState() => _VideoCardWidgetState();
}

class _VideoCardWidgetState extends State<VideoCardWidget> {
  late bool isBookmark;
  @override
  void initState() {
    isBookmark = widget.isbookmark;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
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
                },
                child: AspectRatio(
                  aspectRatio: 342 / 112,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: convertDrivePreviewToDirectImage(
                          widget.mediaModel.thumbnailPath!),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VideoView(
                        mediaModel: widget.mediaModel,
                      );
                    }));
                  },
                  child: const Center(
                    child: CircleAvatar(
                        radius: 21,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        )),
                  ),
                ),
              ),
              widget.topRightIcon != null
                  ? Positioned(
                      right: 12,
                      top: 12,
                      child: InkWell(
                        onTap: widget.onIconTap,
                        child: widget.topRightIcon,
                      ),
                    )
                  : Positioned(
                      right: 12,
                      top: 12,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isBookmark = !isBookmark;
                          });
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
                right: 13,
                bottom: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      '10:14',
                      style:
                          Styles.regularRoboto8.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mediaModel.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Styles.semiBoldPoppins14,
                ),
                widget.isDescriptionAppeared
                    ? Text(
                        widget.mediaModel.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Styles.regularRoboto12,
                      )
                    : const SizedBox.shrink(),
                const Divider(
                  color: AppColors.lightGrey,
                  height: 24,
                ),
                LikesAndCommentsWidget(
                  numberOfComments: widget.mediaModel.commentsCount ?? 0,
                  numberOfLikes: widget.mediaModel.likesCount ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
