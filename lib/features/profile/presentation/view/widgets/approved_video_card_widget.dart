import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class ApprovedVideoCardWidget extends StatelessWidget {
  const ApprovedVideoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VideoCardWidget(
          isDescriptionAppeared: false,
        ),
        SizedBox(height: 12),
        Text(
          'Approved on May 26, 2025 at 10:30 AM',
          style: Styles.regularRoboto12,
        ),
      ],
    );
  }
}
