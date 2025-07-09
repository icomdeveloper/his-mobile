import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/core/helpers/format_duration.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';
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
  late int likesCount;
  @override
  void initState() {
    isBookmark = widget.isbookmark;
    likesCount = widget.mediaModel.likesCount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.mediaModel.description ?? '';
    final isHtml = text.contains(RegExp(r'<[a-z][\s\S]*>'));
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
                        likesCount: likesCount,
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return VideoView(
                        likesCount: likesCount,
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
                          if (!isBookmark) {
                            context
                                .read<BookmarksCubit>()
                                .addToBookmarks(mediaId: widget.mediaModel.id);
                          } else {
                            context.read<BookmarksCubit>().removeFromBookmarks(
                                mediaId: widget.mediaModel.id);
                          }
                        },
                        child: BlocListener<BookmarksCubit, BookmarksState>(
                          listener: (context, state) {
                            if (state is AddToBookmarksSuccess) {
                              setState(() {
                                isBookmark = true;
                              });
                            } else if (state is RemoveFromBookmarksSuccess) {
                              setState(() {
                                isBookmark = false;
                              });
                            } else if (state is RemoveFromBookmarksFailure) {
                              Fluttertoast.showToast(
                                msg: state.errMessage,
                              );
                            } else if (state is AddToBookmarksFailure) {
                              Fluttertoast.showToast(
                                msg: state.errMessage,
                              );
                            }
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
                      formatDuration(widget.mediaModel.duration ?? ""),
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
                SizedBox(height: 4.h),
                widget.isDescriptionAppeared
                    ? isHtml
                        ? Html(
                            data: widget.mediaModel.description ?? '',
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
                              })
                        : Text(
                            widget.mediaModel.description ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: Styles.regularPoppins12
                                .copyWith(color: AppColors.grey),
                          )
                    : const SizedBox.shrink(),
                const Divider(
                  color: AppColors.lightGrey,
                  height: 24,
                ),
                LikesAndCommentsWidget(
                  onLikeChanged: (value) {
                    setState(() {
                      if (value) {
                        likesCount++;
                      } else {
                        likesCount--;
                      }
                    });
                  },
                  mediaId: widget.mediaModel.id!,
                  isLiked: widget.mediaModel.isFavorite ?? false,
                  numberOfComments: widget.mediaModel.commentsCount ?? 0,
                  numberOfLikes: likesCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
