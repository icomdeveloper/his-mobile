import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    super.key,
    required this.position,
  });
  final double position;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      animate: true,
      animationDuration: const Duration(milliseconds: 300),
      dotsCount: 3,
      position: position,
      decorator: const DotsDecorator(
        spacing: EdgeInsets.all(2),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        size: Size(12, 4),
        activeSize: Size(36, 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        colors: [
          Color(0xffADADAD),
          Color(0xffADADAD),
          Color(0xffADADAD),
        ], // Inactive dot colors
        activeColors: [
          AppColors.primaryColor,
          AppColors.primaryColor,
          AppColors.primaryColor,
        ], // Àctive dot colors
      ),
    );
  }
}
