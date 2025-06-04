// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:his/core/utils/app_colors.dart';
// import 'package:his/core/utils/app_text_styles.dart';
// import 'package:his/core/utils/assets.dart';
// import 'package:his/features/category/presentation/view/widgets/comments_list_view.dart';

// class VideoWidget extends StatefulWidget {
//   const VideoWidget({super.key});

//   @override
//   State<VideoWidget> createState() => _VideoWidgetState();
// }

// class _VideoWidgetState extends State<VideoWidget> {
//   bool showComments = false;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           decoration: ShapeDecoration(
//               color: AppColors.primaryColor,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12))),
//           child: Column(
//             children: [
//               ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12)),
//                   child: Image.asset(Assets.assetsImagesVideoTest)),
//               Container(
//                 height: 44.h,
//                 decoration: ShapeDecoration(
//                   color: AppColors.primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     children: [
//                       Text(
//                         '17:34 / 59:32',
//                         style: Styles.regularRoboto12
//                             .copyWith(color: Colors.white),
//                       ),
//                       const Spacer(),
//                       SvgPicture.asset(Assets.assetsImagesVolumeUp),
//                       SizedBox(width: 27.w),
//                       SvgPicture.asset(Assets.assetsImagesFilter),
//                       SizedBox(width: 27.w),
//                       SvgPicture.asset(Assets.assetsImagesVideoCategory),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 8.h),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               showComments = !showComments;
//               if (showComments) {
//                 _scrollToBottom();
//               }
//             });
//           },
//           child: Row(
//             children: [
//               ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: 320.w),
//                 child: const Text(
//                   'feugiat ullamcorper suspendisse amet.',
//                   style: Styles.semiBoldPoppins14,
//                 ),
//               ),
//               const Spacer(),
//               CircleAvatar(
//                 backgroundColor: const AppColors.lightGrey,
//                 radius: 10.r,
//                 child: SvgPicture.asset(showComments
//                     ? Assets.assetsImagesArrowUp
//                     : Assets.assetsImagesArrowDown),
//               ),
//             ],
//           ),
//         ),
//         const Divider(),
//         if (showComments) ...[
//           SizedBox(
//             height: 234.h,
//             child: CommentsListView(controller: _scrollController),
//           ),
//           const Divider(),
//         ]
//       ],
//     );
//   }
// }

import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/presentation/view/widgets/comment_text_field.dart';
import 'package:his/features/category/presentation/view/widgets/comments_list_view.dart';
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
  late ChewieController chewieController;
  late ScrollController _scrollController;

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
    chewieController = ChewieController(
      placeholder: Center(
        child: Image.asset(Assets.assetsImagesDoctestimage),
      ),
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
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Chewie(controller: chewieController))),
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
                  duration: 500.ms,
                ),
                FadeEffect(
                  duration: 500.ms,
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
          const Divider(),
          SizedBox(
            height: 250.h,
            child: CommentsListView(controller: _scrollController),
          ),
          const SizedBox(height: 12),
          const CommentTextField(),
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
          curve: Curves.easeOut,
        );
      }
    });
  }
}
