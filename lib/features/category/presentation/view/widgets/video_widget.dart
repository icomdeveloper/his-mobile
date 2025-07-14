import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/core/helpers/convert_drive_files.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/cubits/add_comments_cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/get_comments_cubit/get_comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/views_cubit/views_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comment_text_field.dart';
import 'package:his/features/category/presentation/view/widgets/comments_list_view.dart';
import 'package:his/features/category/presentation/view/widgets/comments_list_view_bloc_builder.dart';
import 'package:his/features/category/presentation/view/widgets/pdf_and_image_container.dart';
import 'package:his/features/category/presentation/view/widgets/pdf_view.dart';
import 'package:his/features/category/presentation/view/widgets/show_image_widget.dart';
import 'package:his/features/home/presentation/view/widgets/likes_and_comment_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/edit_video_view_body.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
    this.mediaModel,
    this.isEdit = false,
    required this.likesCount,
  });
  final MediaModel? mediaModel;
  final bool isEdit;
  final int likesCount;
  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  bool showDetails = false;
  ChewieController? chewieController;
  bool started = false;
  // double ratingValue = 3;

  @override
  void initState() {
    super.initState();

    String url = getDirectVideoUrl(widget.mediaModel!.filePath!);
    if (defaultTargetPlatform == TargetPlatform.android) {
      videoPlayerController = VideoPlayerController.contentUri(Uri.parse(url));
    } else {
      // Use another supported constructor (e.g., fromNetwork, fromFile)
      videoPlayerController = VideoPlayerController.network(url);
    }
    /* videoPlayerController = VideoPlayerController.contentUri(
      Uri.parse(
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
    );*/
  }

  initChewieController() {
    chewieController = ChewieController(
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
      allowedScreenSleep: false,
      videoPlayerController: videoPlayerController,
      progressIndicatorDelay:
          Platform.isAndroid ? const Duration(days: 1) : null,
      looping: true,
      aspectRatio: 16 / 9,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.mediaModel?.description ?? '';
    final isHtml = text.contains(RegExp(r'<[a-z][\s\S]*>'));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: started
                      ? Chewie(controller: chewieController!)
                      : Stack(
                          children: [
                            Positioned.fill(
                              child: CachedNetworkImage(
                                imageUrl: widget.mediaModel!.thumbnailPath!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                onPressed: () {
                                  initChewieController();
                                  context.read<ViewsCubit>().incrementViews(
                                      mediaId: widget.mediaModel!.id!);
                                  setState(() {
                                    started = true;
                                  });
                                },
                                icon: const CircleAvatar(
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 34,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                          radius: 28,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 32,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))),
          SizedBox(height: 8.h),
          widget.isEdit
              ? EditVideoViewBody(
                  mediaModel: widget.mediaModel!,
                )
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDetails = !showDetails;
                        });
                      },
                      child: Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 320.w),
                            child: Text(
                              widget.mediaModel?.title ?? '',
                              style: Styles.semiBoldPoppins14,
                            ),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            backgroundColor: AppColors.lightGrey,
                            radius: 10.r,
                            child: SvgPicture.asset(showDetails
                                ? Assets.assetsImagesArrowUp
                                : Assets.assetsImagesArrowDown),
                          ),
                        ],
                      ),
                    ),

                    if (showDetails) ...[
                      Animate(
                        effects: [
                          MoveEffect(
                            duration: 300.ms,
                          ),
                          FadeEffect(
                            duration: 300.ms,
                          ),
                        ],
                        child: Column(
                          children: [
                            SizedBox(height: 4.h),
                            isHtml
                                ? Html(
                                    data: widget.mediaModel?.description ?? '',
                                    style: {
                                        "p": Style(
                                            color: AppColors.grey,
                                            fontSize: FontSize(12.sp),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                      })
                                : Text(
                                    widget.mediaModel?.description ?? '',
                                    style: Styles.regularPoppins12
                                        .copyWith(color: AppColors.grey),
                                  ),
                            Row(
                              children: [
                                const Icon(Icons.visibility_outlined,
                                    color: AppColors.grey),
                                SizedBox(width: 8.w),
                                BlocBuilder<ViewsCubit, ViewsState>(
                                  builder: (context, state) {
                                    return Text(
                                      state is ViewsSuccess
                                          ? '${state.viewsCount} views'
                                          : '${widget.mediaModel?.views ?? 0} views',
                                      style: Styles.regularPoppins12
                                          .copyWith(color: AppColors.grey),
                                    );
                                  },
                                ),
                                // const SizedBox(width: 40),
                                // SizedBox(
                                //   width: 12.w,
                                //   child: SvgPicture.asset(
                                //     Assets.assetsImagesBookmarked,
                                //     colorFilter: const ColorFilter.mode(
                                //         AppColors.grey, BlendMode.srcIn),
                                //   ),
                                // ),
                                // SizedBox(width: 8.w),
                                // Text(
                                //   '${0} Saved',
                                //   style: Styles.regularPoppins12
                                //       .copyWith(color: AppColors.grey),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                    const Divider(
                      color: AppColors.lightGrey,
                    ),
                    widget.mediaModel?.pdf != null
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => PdfView(
                                          url: widget.mediaModel!.pdf!)));
                            },
                            child: PDFAndImageContainer(
                              title: 'Document',
                              subTitle: 'PDF',
                              trailingIcon:
                                  SvgPicture.asset(Assets.assetsImagesPdfView),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 12,
                    ),
                    widget.mediaModel?.image != null
                        ? ShowImageWidget(image: widget.mediaModel!.image!)
                        : const SizedBox.shrink(),
                    const SizedBox(height: 12),
                    // Text(
                    //   'Admin Rating (1-5)',
                    //   style: Styles.semiBoldPoppins14
                    //       .copyWith(color: const Color(0xff1C1C0D)),
                    // ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    // RatingStars(
                    //   valueLabelVisibility: false,
                    //   value: ratingValue,
                    //   onValueChanged: (v) {
                    //     setState(() {
                    //       ratingValue = v;
                    //     });
                    //   },
                    //   starBuilder: (index, color) => Icon(
                    //     Icons.star_sharp,
                    //     color: color,
                    //   ),
                    //   starCount: 5,
                    //   starSize: 27,
                    //   starSpacing: 5,
                    //   maxValue: 5,
                    //   animationDuration: const Duration(milliseconds: 400),
                    //   starOffColor: AppColors.lightGrey,
                    //   starColor: const Color(0xFFE0B610),
                    // ),
                    // const Divider(
                    //   color: AppColors.lightGrey,
                    //   thickness: 1,
                    //   height: 24,
                    // ),
                    LikesAndCommentsWidget(
                      isLiked: widget.mediaModel!.isLiked,
                      mediaId: widget.mediaModel!.id!,
                      numberOfComments: widget.mediaModel?.commentsCount ?? 0,
                      numberOfLikes: widget.likesCount,
                    ),
                    const SizedBox(height: 14),

                    CommentListViewBlocBuilder(
                      mediaId: widget.mediaModel!.id!,
                    ),
                    const SizedBox(height: 12),
                    BlocListener<CommentsCubit, CommentsState>(
                      listener: (context, state) {
                        if (state is AddCommentsFailure) {
                          Fluttertoast.showToast(msg: state.message);
                        }
                        if (state is AddCommentSuccess) {
                          setState(() {
                            commentsList.add(state.comment);
                          });
                          //   context
                          //       .read<GetCommentsCubit>()
                          //       .getComments(mediaId: widget.mediaModel!.id!);
                        }
                        if (state is AddReplytSuccess) {
                          // setState(() {
                          //   repliesList[state.replyModel.parentId]!.add(state.replyModel);
                          // });
                          context
                              .read<GetCommentsCubit>()
                              .getComments(mediaId: widget.mediaModel!.id!);
                        }
                      },
                      child: CommentTextField(
                        controller:
                            context.read<CommentsCubit>().commentController,
                        onTap: () {
                          if (context
                              .read<CommentsCubit>()
                              .commentController
                              .text
                              .isEmpty) {
                            return;
                          }
                          context
                              .read<CommentsCubit>()
                              .addComment(mediaId: widget.mediaModel!.id!);
                        },
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
