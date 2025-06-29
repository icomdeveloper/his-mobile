import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';

class EditVideoView extends StatelessWidget {
  const EditVideoView({super.key, required this.mediaModel});
  final MediaModel mediaModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Post', style: Styles.semiBoldRoboto20),
        backgroundColor: Colors.white,
        elevation: 0,
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
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Save',
              style: Styles.semiBoldPoppins14,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: VideoWidget(
          mediaModel: mediaModel,
          isEdit: true,
        ),
      ),
    );
  }
}
