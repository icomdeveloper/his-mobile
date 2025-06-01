import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_text_styles.dart';

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({super.key, required this.text, required this.image});
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xffEDF1F3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 18,
              child:
                  AspectRatio(aspectRatio: 1, child: SvgPicture.asset(image))),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: Styles.semiBoldInter14,
          ),
        ],
      ),
    );
  }
}
