import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/my_videos_view_body.dart';

class MyVideosView extends StatelessWidget {
  const MyVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'My Videos'),
      body: const MyVideosViewBody(),
    );
  }
}
