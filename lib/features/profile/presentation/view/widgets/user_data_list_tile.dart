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
  });
  final String title, image;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
          padding: const EdgeInsets.all(8),
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
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor,
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
    );
  }
}
