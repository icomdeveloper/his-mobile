import 'package:flutter/material.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/on_boarding/presentation/view/widgets/on_boarding_page_view_item.dart';

class OnBoradingPageView extends StatelessWidget {
  const OnBoradingPageView({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: const [
        OnBoardingPageViewItem(
          image: Assets.assetsImagesOnBoarding1,
          title: 'Understand Your Health',
          subtitle:
              'Explore expert content about male reproductive health, made simple and accessible.',
        ),
        OnBoardingPageViewItem(
          image: Assets.assetsImagesOnBoarding2,
          title: 'Free & Confidential',
          subtitle:
              'Access medical articles and visuals anytime, with full privacy and no cost.',
        ),
        OnBoardingPageViewItem(
          image: Assets.assetsImagesOnBoarding3,
          title: 'Watch, Learn, Grow',
          subtitle:
              'High-quality videos and illustrations to help you understand symptoms, causes, and treatments.',
        ),
      ],
    );
  }
}
