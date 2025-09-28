import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class FormItem extends StatelessWidget {
  const FormItem({
    super.key,
    required this.index,
    required this.subtitle,
    required this.title,
    required this.data,
  });
  final int index;
  final String title;
  final String? subtitle;
  final Widget data;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedShape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12),
      ),
      title: Row(
        children: [
          Text('$index. ', style: Styles.semiBoldPoppins16),
          Text(title, style: Styles.semiBoldPoppins16),
        ],
      ),
      subtitle: subtitle == null
          ? null
          : Text(subtitle!,
              style: Styles.regularPoppins12.copyWith(color: AppColors.grey)),
      children: [data],
    );
  }
}
