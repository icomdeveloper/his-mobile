import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/main_screen/data/model/nav_bar_model.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.navBarModel});
  final NavBarModel navBarModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          navBarModel.image,
          colorFilter:
              const ColorFilter.mode(Color(0xffCACACA), BlendMode.srcIn),
        ),
        Text(
          navBarModel.title,
          style: Styles.mediumRoboto12.copyWith(color: const Color(0xffCACACA)),
        ),
      ],
    );
  }
}
