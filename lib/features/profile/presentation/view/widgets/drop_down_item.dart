import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';

class DropDownItemWidget extends StatelessWidget {
  const DropDownItemWidget(
      {super.key, required this.image, required this.name});
  final String image, name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: 20,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: Styles.regularRoboto12,
          ),
        ],
      ),
    );
  }
}
