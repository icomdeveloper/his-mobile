import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
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
        title: const Text('Edit Post', style: Styles.semiBoldPoppins20),
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
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                useRootNavigator: false,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Column(
                    children: [
                      SvgPicture.asset(Assets.assetsImagesSuccess),
                      const SizedBox(height: 10),
                      const Text(
                        'Success !',
                        style: Styles.semiBoldPoppins20,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Post saved successfully.',
                        style: Styles.regularPoppins14,
                      ),
                    ],
                  ),
                  actions: [
                    CustomTextButton(
                      text: 'Back',
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.white,
                      borderColor: AppColors.primaryColor,
                      textColor: AppColors.primaryColor,
                      isArrowAppear: false,
                    ),
                  ],
                ),
              );
            },
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
          likesCount: mediaModel.likesCount ?? 0,
          mediaModel: mediaModel,
          isEdit: true,
        ),
      ),
    );
  }
}
