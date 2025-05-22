import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/category/presentation/view/widgets/comments_list_view.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool showComments = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: Image.asset(Assets.assetsImagesVideoTest)),
              Container(
                height: 44.h,
                decoration: ShapeDecoration(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        '17:34 / 59:32',
                        style: Styles.regularRoboto12
                            .copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      SvgPicture.asset(Assets.assetsImagesVolumeUp),
                      SizedBox(width: 27.w),
                      SvgPicture.asset(Assets.assetsImagesFilter),
                      SizedBox(width: 27.w),
                      SvgPicture.asset(Assets.assetsImagesVideoCategory),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            setState(() {
              showComments = !showComments;
              if (showComments) {
                _scrollToBottom();
              }
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
                backgroundColor: const Color(0xffEDEDED),
                radius: 10.r,
                child: SvgPicture.asset(showComments
                    ? Assets.assetsImagesArrowUp
                    : Assets.assetsImagesArrowDown),
              ),
            ],
          ),
        ),
        const Divider(),
        if (showComments) ...[
          SizedBox(
            height: 234.h,
            child: CommentsListView(controller: _scrollController),
          ),
          const Divider(),
        ]
      ],
    );
  }
}
