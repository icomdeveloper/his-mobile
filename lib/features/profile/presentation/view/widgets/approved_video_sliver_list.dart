import 'package:flutter/material.dart';
import 'package:his/features/profile/presentation/view/widgets/approved_video_card_widget.dart';

class ApprovedVideosSliverList extends StatelessWidget {
  const ApprovedVideosSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemCount: 2,
      itemBuilder: (context, index) => const ApprovedVideoCardWidget(),
    );
  }
}
