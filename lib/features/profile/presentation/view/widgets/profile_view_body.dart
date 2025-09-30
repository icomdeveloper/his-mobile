import 'dart:developer';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/profile/data/repo/delete_user_repo.dart';
import 'package:his/features/profile/data/repo/edit_profile_repo.dart';
import 'package:his/features/profile/data/repo/reset_password_repo.dart';
import 'package:his/features/profile/data/repo/update_profile_image_repo.dart';
import 'package:his/features/profile/presentation/cubits/delete_user_cubit/delete_user_cubit.dart';
import 'package:his/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:his/features/profile/presentation/cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:his/features/profile/presentation/cubits/reset_password_cubit/reset_password_cubit.dart';
import 'package:his/features/profile/presentation/cubits/update_profile_image_cubit/update_profile_image_cubit.dart';
import 'package:his/features/profile/presentation/view/change_password_view.dart';
import 'package:his/features/profile/presentation/view/edit_profile_view.dart';
import 'package:his/features/profile/presentation/view/my_videos_view.dart';
import 'package:his/features/profile/presentation/view/help_center_view.dart';
import 'package:his/features/profile/presentation/view/widgets/delete_account_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/logout_widget.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_row_widget.dart';
import 'package:his/notifications/bloc/notifications_bloc.dart';
import 'package:his/notifications/bloc/notifications_state.dart';
import 'package:his/notifications/presentation/notification_page.dart';

import 'profile_user_info.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  Key _refreshKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    context.read<GetUserInfoCubit>().getUserInfo();
    context.read<NotificationCubit>().loadUnreadNotifications();
  }

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
            child: BlocProvider(
              create: (context) =>
                  UpdateProfileImageCubit(getIt<UpdateProfileImageRepo>()),
              child: ProfileUserInfo(
                key: _refreshKey,
              ),
            ),
          ),
        ),
        Positioned(
          top: 165.h,
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
                    style: Styles.semiBoldPoppins20,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  UserDataRowWidget(
                      title: 'Change Profile Details',
                      trailing:
                          SvgPicture.asset(Assets.assetsImagesArrowForward),
                      image: Assets.assetsImagesProfile,
                      onTap: () async {
                        log("Clicked");
                        final result = await Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, animation,
                                        secondaryAnimation) =>
                                    MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => EditProfileCubit(
                                              getIt<EditProfileRepo>()),
                                        ),
                                        BlocProvider.value(
                                          value:
                                              context.read<GetUserInfoCubit>(),
                                        ),
                                      ],
                                      child: const EditProfileView(),
                                    ),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
                                    SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                transitionDuration:
                                    const Duration(milliseconds: 300)));
                        if (result == 'refresh') {
                          setState(() {
                            log("result =>>>>>>>>>>>>>>>>>>> $result");
                            _refreshKey = UniqueKey();
                          });
                        }
                      }),
                  const SizedBox(height: 12),
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
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Content',
                    style: Styles.semiBoldPoppins20,
                  ),
                  const SizedBox(height: 12),
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
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 12),
                  // UserDataRowWidget(
                  //   title: 'My Articles',
                  //   image: Assets.assetsImagesCategories,
                  //   trailing: SvgPicture.asset(Assets.assetsImagesArrowForward),
                  //   onTap: () => Navigator.push(
                  //     context,
                  //     PageRouteBuilder(
                  //       pageBuilder: (_, __, ___) => const MyArticlesView(),
                  //       transitionsBuilder:
                  //           (context, animation, secondaryAnimation, child) =>
                  //               FadeTransition(
                  //         opacity: animation,
                  //         child: child,
                  //       ),
                  //       transitionDuration: const Duration(milliseconds: 500),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 32),
                  const Text(
                    'Settings',
                    style: Styles.semiBoldPoppins20,
                  ),
                  SizedBox(height: 12.h),
                  BlocProvider(
                    create: (context) => DeleteUserCubit(
                      getIt<DeleteUserRepo>(),
                    ),
                    child: const DeleteAccountWidget(),
                  ),
                  SizedBox(height: 12.h),
                  const LogoutWidget(),
                  const SizedBox(height: 32),
                  const Text(
                    'Privacy & Help center ',
                    style: Styles.semiBoldPoppins20,
                  ),
                  const SizedBox(height: 12),
                  UserDataRowWidget(
                    title: 'Help Center',
                    image: Assets.assetsImagesInfo,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const PolicyListView(),
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
                  const SizedBox(height: 12),
                  BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      return UserDataRowWidget(
                        title: 'Notifications',
                        prefixIcon: badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: -5, end: -5),
                          badgeContent: Text(
                            state is UnReadNotificationsSuccess
                                ? state.data.total.toString()
                                : '',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: AppColors.primaryColor,
                          ),
                          showBadge: state is UnReadNotificationsSuccess &&
                              state.data.total! > 0,
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const ShapeDecoration(
                                color: AppColors.lightPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              child: SizedBox(
                                width: 18,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: SvgPicture.asset(
                                    Assets.assetsImagesNotification,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<NotificationCubit>(),
                                child: const NotificationsPage(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )

                  // BlocBuilder<UnreadCountCubit, int>(
                  //   builder: (context, count) {
                  //     return UserDataRowWidget(
                  //       title: 'Notifications',
                  //       prefixIcon: badges.Badge(
                  //         position:
                  //             badges.BadgePosition.topEnd(top: -5, end: -5),
                  //         badgeContent: Text(
                  //           count.toString(),
                  //           style: const TextStyle(
                  //               color: Colors.white, fontSize: 12),
                  //         ),
                  //         badgeStyle: const badges.BadgeStyle(
                  //           badgeColor: AppColors.primaryColor,
                  //         ),
                  //         showBadge: count > 0,
                  //         child: Container(
                  //             padding: const EdgeInsets.all(12),
                  //             decoration: const ShapeDecoration(
                  //               color: AppColors.lightPrimaryColor,
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(8)),
                  //               ),
                  //             ),
                  //             child: SizedBox(
                  //               width: 18,
                  //               child: AspectRatio(
                  //                 aspectRatio: 1,
                  //                 child: SvgPicture.asset(
                  //                   Assets.assetsImagesNotification,
                  //                   colorFilter: const ColorFilter.mode(
                  //                     AppColors.primaryColor,
                  //                     BlendMode.srcIn,
                  //                   ),
                  //                 ),
                  //               ),
                  //             )),
                  //       ),
                  //       onTap: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (_) => const NotificationsPage(),
                  //           ),
                  //         ).then((_) {
                  //           // reload count when returning (if needed)
                  //           context.read<NotificationCubit>().loadNotifications(
                  //                 refresh: true,
                  //                 unreadCubit: context.read<UnreadCountCubit>(),
                  //               );
                  //         });
                  //       },
                  //     );
                  //   },
                  // ),

                  // UserDataRowWidget(
                  //             title: 'Notifications',
                  //             prefixIcon: badges.Badge(
                  //               position:
                  //                   badges.BadgePosition.topEnd(top: -5, end: -5),
                  //               badgeContent: Text(
                  //                 notifier.unreadCount.toString(),
                  //                 style: const TextStyle(
                  //                     color: Colors.white, fontSize: 12),
                  //               ),
                  //               badgeStyle: const badges.BadgeStyle(
                  //                 badgeColor: AppColors.primaryColor,
                  //               ),
                  //               showBadge: notifier.unreadCount > 0,
                  //               child: Container(
                  //                   padding: const EdgeInsets.all(12),
                  //                   decoration: const ShapeDecoration(
                  //                     color: AppColors.lightPrimaryColor,
                  //                     shape: RoundedRectangleBorder(
                  //                       borderRadius:
                  //                           BorderRadius.all(Radius.circular(8)),
                  //                     ),
                  //                   ),
                  //                   child: SizedBox(
                  //                     width: 18,
                  //                     child: AspectRatio(
                  //                       aspectRatio: 1,
                  //                       child: SvgPicture.asset(
                  //                         Assets.assetsImagesNotification,
                  //                         colorFilter: const ColorFilter.mode(
                  //                           AppColors.primaryColor,
                  //                           BlendMode.srcIn,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )),
                  //             ),
                  //             onTap: () {
                  //               Navigator.push(
                  //                 context,
                  //                 PageRouteBuilder(
                  //                   pageBuilder: (_, __, ___) => MultiBlocProvider(
                  //                     providers: [
                  //                       BlocProvider.value(
                  //                         value: context.read<NotificationCubit>(),
                  //                       ),
                  //                     ],
                  //                     child: const NotificationView(),
                  //                   ),
                  //                   transitionsBuilder: (context, animation,
                  //                           secondaryAnimation, child) =>
                  //                       FadeTransition(
                  //                     opacity: animation,
                  //                     child: child,
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
