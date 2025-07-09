import 'package:flutter/material.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class ApprovedVideoCardWidget extends StatelessWidget {
  const ApprovedVideoCardWidget({super.key, required this.mediaModel});
  final MediaModel mediaModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VideoCardWidget(
          mediaModel: mediaModel,
          isDescriptionAppeared: false,
          topRightIcon: const SizedBox.shrink(),
        ),
        // const SizedBox(height: 8),
        // Text(
        //   'Approved on May 26, 2025 at 10:30 AM',
        //   style: Styles.regularPoppins12.copyWith(color: AppColors.grey),
        // ),
      ],
    );
  }
}
