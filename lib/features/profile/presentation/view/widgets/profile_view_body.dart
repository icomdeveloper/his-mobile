import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/profile/presentation/view/widgets/profile_data_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        width: double.infinity,
        height: 250.h,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          image: DecorationImage(
            image: AssetImage(
              Assets.assetsImagesProfileBackground,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: Styles.semiBoldRoboto20.copyWith(color: Colors.white),
              ),
              SizedBox(height: 12.h),
              Row(children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 26.r,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 23.r,
                        backgroundColor: const Color(0xffDBEEF2),
                        child: const Icon(Icons.person,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    Positioned(
                      bottom: -5.h,
                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: 9.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7.r,
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(
                            Icons.edit,
                            size: 8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Column(
                  children: [
                    Text(
                      'Lorem ipsum dolor',
                      style: Styles.semiBoldPoppins14
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      'Loremipsumdolor@his.org',
                      style:
                          Styles.regularRoboto12.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
      Positioned(
        top: 200.h,
        left: 0,
        right: 0,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            color: Color(0xFFFFF8F8),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileDataWidget(
                  data: 'Loremipsum19',
                  title: 'Username',
                ),
                SizedBox(height: 14),
                ProfileDataWidget(
                  data: 'Loremipsumdolor@his.org',
                  title: 'Email',
                ),
                SizedBox(height: 14),
                ProfileDataWidget(
                  data: '010299300225',
                  title: 'Phone Number',
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
