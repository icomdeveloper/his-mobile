import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/view/widgets/recommended_videos_list.dart';

class RecommendedVideosView extends StatelessWidget {
  const RecommendedVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.grey,
            size: 18,
          ),
        ),
        title: const Text(
          'Recommended Videos',
          style: Styles.semiBoldRoboto20,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: RecommendedVideosList(),
      ),
    );
  }
}
