import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
import 'package:his/features/on_boarding/presentation/view/widgets/arrow_container.dart';
import 'package:his/features/on_boarding/presentation/view/widgets/custom_dots_indicator.dart';
import 'package:his/features/on_boarding/presentation/view/widgets/on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController controller;
  int currentPage = 0;
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    controller.addListener(
      () {
        currentPage = controller.page!.round();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: currentPage != 2,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            maintainSemantics: true,
            maintainInteractivity: true,
            child: InkWell(
              onTap: () {
                controller.animateToPage(2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              child: Text(
                'Skip',
                style: Styles.semiBoldPoppins14.copyWith(
                    color: AppColors.grey,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          SizedBox(
            height: 90.h,
          ),
          Expanded(
            child: OnBoradingPageView(controller: controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                maintainSemantics: true,
                maintainInteractivity: true,
                visible: currentPage != 0,
                child: ArrowContainer(
                    onTap: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: Icons.arrow_back,
                    color: const Color(0xffDFDFDF)),
              ),
              const Spacer(),
              CustomDotsIndicator(
                position: currentPage.toDouble(),
              ),
              const Spacer(),
              Visibility(
                maintainAnimation: true,
                maintainSize: true,
                maintainState: true,
                maintainSemantics: true,
                maintainInteractivity: true,
                visible: currentPage != 2,
                child: ArrowContainer(
                  color: AppColors.primaryColor,
                  icon: Icons.arrow_forward_rounded,
                  onTap: () {
                    if (currentPage < 2) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 37.h,
          ),
          Visibility(
            visible: currentPage == 2,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            maintainSemantics: true,
            maintainInteractivity: true,
            child: CustomTextButton(
              onPressed: () {
                Prefs.setBool(PrefsKeys.isOnBoardingSeen, true);
                Navigator.pushReplacementNamed(context, MainView.routeName);
              },
              text: 'Get Started',
            ),
          ),
          SizedBox(
            height: 55.h,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
