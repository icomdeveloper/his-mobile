import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class UserDataListTile extends StatelessWidget {
  const UserDataListTile({
    super.key,
    required this.title,
    this.subTitle,
    required this.image,
    this.imageColor = AppColors.primaryColor,
    this.padding,
    this.trailing,
  });
  final String title, image;
  final String? subTitle;
  final Color imageColor;
  final double? padding;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 50,
      leading: Container(
          padding: EdgeInsets.all(padding ?? 8),
          decoration: const ShapeDecoration(
            color: AppColors.lightPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          child: SizedBox(
            width: 18,
            child: AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(
                  imageColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )),
      title: Text(
        title,
        style:
            Styles.semiBoldPoppins14.copyWith(color: const Color(0xff121417)),
      ),
      subtitle: Text(
        subTitle ?? '',
        style: Styles.regularPoppins12.copyWith(color: const Color(0xff61758A)),
      ),
      trailing: trailing,
    );
  }
}
