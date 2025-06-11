import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/help_center_container.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, title: 'Help Center'),
        body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemCount: 4,
          itemBuilder: (context, index) => const HelpCenterContainer(),
        ));
  }
}
