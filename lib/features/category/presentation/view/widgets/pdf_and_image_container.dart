import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_list_tile.dart';

class PDFAndImageContainer extends StatelessWidget {
  const PDFAndImageContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
  });
  final String title, subTitle, trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.lightGrey, width: 1))),
      child: Column(
        children: [
          UserDataListTile(
            title: title,
            image: Assets.assetsImagesDocument,
            subTitle: subTitle,
            padding: 12,
            trailing: SvgPicture.asset(trailingIcon),
          ),
        ],
      ),
    );
  }
}
