import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/profile/data/repo/reset_password_repo.dart';
import 'package:his/features/profile/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:his/features/profile/presentation/view/change_password_view.dart';
import 'package:his/features/profile/presentation/view/my_videos_view.dart';
import 'package:his/features/profile/presentation/view/help_center_view.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_list_tile.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_row_widget.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 50.h,
            ),
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          getUserData().userInfo?.name ?? '',
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          style: Styles.semiBoldPoppins14
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          getUserData().userInfo?.email ?? '',
                          style: Styles.regularPoppins12
                              .copyWith(color: Colors.white),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50.w, 25.h),
                        maximumSize: Size(60.w, 35.h),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Edit',
                        style: Styles.regularRoboto12
                            .copyWith(color: AppColors.primaryColor),
                      ))
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
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account',
                    style: Styles.semiBoldRoboto20,
                  ),
                  UserDataListTile(
                    title: 'Phone Number',
                    subTitle: getUserData().userInfo?.phone ?? '',
                    image: Assets.assetsImagesPhone,
                  ),
                  UserDataListTile(
                    title: 'Username',
                    subTitle: getUserData().userInfo?.username ?? '',
                    image: Assets.assetsImagesProfile,
                  ),
                  SizedBox(height: 13.h),
                  UserDataRowWidget(
                    title: 'Change Password',
                    image: Assets.assetsImagesPassword,
                    trailing: SvgPicture.asset(Assets.assetsImagesArrowForward),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => BlocProvider(
                            create: (context) =>
                                ResetPasswordCubit(getIt<ResetPasswordRepo>()),
                            child: const ChangePasswordView(),
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Content',
                    style: Styles.semiBoldRoboto20,
                  ),
                  SizedBox(height: 12.h),
                  UserDataRowWidget(
                    title: 'My Videos',
                    image: Assets.assetsImagesVideoIcon,
                    trailing: SvgPicture.asset(Assets.assetsImagesArrowForward),
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const MyVideosView(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Settings',
                    style: Styles.semiBoldRoboto20,
                  ),
                  SizedBox(height: 12.h),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          actionsAlignment: MainAxisAlignment.spaceBetween,
                          title: const Text(
                            'Are you sure you want to delete your account ?',
                            style: Styles.semiBoldRoboto20,
                          ),
                          content: const Text(
                            'Deleting your account will permanently remove all your data, including your profile, posts, and any other information associated with your account .',
                            style: Styles.regularPoppins14,
                          ),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 35.w, vertical: 10.h),
                                  side: const BorderSide(
                                      color: Color(0xFFD60000), width: 1)),
                              onPressed: null,
                              child: Text(
                                'Cancel',
                                style: Styles.regularPoppins14
                                    .copyWith(color: const Color(0xFFD60000)),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 35.w, vertical: 10.h),
                                backgroundColor: const Color(0xFFD60000),
                              ),
                              onPressed: null,
                              child: Text(
                                'Delete',
                                style: Styles.regularPoppins14
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const UserDataRowWidget(
                      title: 'Delete Account',
                      image: Assets.assetsImagesDelete,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  UserDataRowWidget(
                    onTap: () {
                      showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (_) => AlertDialog(
                                  title: const Text(
                                    ' Log out of your account ?',
                                    style: Styles.semiBoldInter14,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: Styles.regularPoppins14
                                            .copyWith(color: AppColors.grey),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Prefs.setBool(
                                              PrefsKeys.isLoggedIn, false);
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  const LoginView(),
                                              transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) =>
                                                  SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: const Offset(1, 0),
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: child,
                                              ),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        child: Text(
                                          'Logout',
                                          style: Styles.regularPoppins14
                                              .copyWith(
                                                  color:
                                                      const Color(0xFFD60000)),
                                        ))
                                  ]));
                    },
                    title: 'Logout',
                    image: Assets.assetsImagesLogout,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Privacy & Help center ',
                    style: Styles.semiBoldRoboto20,
                  ),
                  const SizedBox(height: 12),
                  UserDataRowWidget(
                    title: 'Help Center',
                    image: Assets.assetsImagesInfo,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const HelpCenterView(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
