import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/presentation/cubits/cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comment_text_field.dart';
import 'package:his/features/category/presentation/view/widgets/comments_list_view.dart';
import 'package:his/features/home/presentation/view/widgets/likes_and_comment_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_list_tile.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  bool showDetails = false;
  ChewieController? chewieController;
  late ScrollController _scrollController;
  bool started = false;
  // double ratingValue = 3;

  String url =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollToBottom();
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
                      : Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage(Assets.assetsImagesDoctestimage),
                                fit: BoxFit.cover),
                          ),
                          child: IconButton(
                            onPressed: () {
                              initChewieController();
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
                                      backgroundColor: AppColors.primaryColor,
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32,
                                      )),
                                ),
                              ),
                            ),
                          )))),
          SizedBox(height: 8.h),
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
                  child: const Text(
                    'feugiat ullamcorper suspendisse amet.',
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
                  const Text(
                    'Lorem ipsum dolor sit amet consectetur. Sed cursus purus. Lorem ipsum dolor sit amet consectetur. Sed cursus purus.',
                    style: Styles.regularRoboto12,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.visibility_outlined,
                          color: AppColors.grey),
                      SizedBox(width: 8.w),
                      Text(
                        '22.3k views',
                        style: Styles.regularRoboto12
                            .copyWith(color: AppColors.grey),
                      ),
                      const SizedBox(width: 40),
                      SizedBox(
                        width: 12.w,
                        child: SvgPicture.asset(
                          Assets.assetsImagesBookmarked,
                          colorFilter: const ColorFilter.mode(
                              AppColors.grey, BlendMode.srcIn),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '1.648 Saved',
                        style: Styles.regularRoboto12
                            .copyWith(color: AppColors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
          const Divider(
            color: AppColors.lightGrey,
          ),
          const UserDataListTile(
            title: 'Document',
            image: Assets.assetsImagesDocument,
            subTitle: 'PDF',
            padding: 12,
          ),
          const Divider(
            color: AppColors.lightGrey,
          ),
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
          const LikesAndCommentsWidget(),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Comments',
                style: Styles.semiBoldPoppins14,
              ),
              Text(
                '46 Comments',
                style: Styles.regularRoboto12.copyWith(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 350.h,
            child: CommentsListView(controller: _scrollController),
          ),
          const SizedBox(height: 12),
          BlocListener<CommentsCubit, CommentsState>(
            listener: (context, state) {
              if (state is AddCommentsFailure) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: CommentTextField(
              controller: context.read<CommentsCubit>().commentController,
              onTap: () {
                context.read<CommentsCubit>().addComment(mediaId: 1);
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }
}
