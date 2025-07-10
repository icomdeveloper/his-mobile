import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/home/data/repo/featured_videos_repo.dart';
import 'package:his/features/home/data/repo/global_search_repo.dart';
import 'package:his/features/home/data/repo/recently_added_repo.dart';
import 'package:his/features/home/presentation/cubits/featured_videos_cubit/featured_videos_cubit.dart';
import 'package:his/features/home/presentation/cubits/global_search_cubit/global_search_cubit.dart';
import 'package:his/features/home/presentation/cubits/recently_added_cubit/recently_added_cubit.dart';
import 'package:his/features/home/presentation/view/global_search_view.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos.dart';
import 'package:his/features/home/presentation/view/widgets/recently_added_bloc_builder.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  // bool _showArticleHeader = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: () {
                    if (!Prefs.getBool(PrefsKeys.isLoggedIn)) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const LoginView(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => BlocProvider(
                              create: (context) =>
                                  GlobalSearchCubit(getIt<GlobalSearchRepo>()),
                              child: const GlobalSearchView(),
                            ),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          ));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(
                              width: 1, color: AppColors.lightGrey)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.assetsImagesSearch,
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Text('Search ...',
                            style: Styles.regularPoppins12
                                .copyWith(color: AppColors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  FeaturedVideosCubit(getIt<FeaturedVideosRepo>())
                    ..getFeaturedVideos(),
              child: const FeaturedVideos(),
            ),
          ),
          // if (_showArticleHeader)
          //   SliverToBoxAdapter(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         SizedBox(
          //           height: 12.h,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             const Text('Articles', style: Styles.semiBoldPoppins20),
          //             InkWell(
          //               onTap: () {
          //                 Navigator.of(context).push(
          //                   PageRouteBuilder(
          //                     pageBuilder: (_, __, ___) =>
          //                         const SeeAllArticlesView(),
          //                     transitionsBuilder: (context, animation,
          //                             secondaryAnimation, child) =>
          //                         FadeTransition(
          //                       opacity: animation,
          //                       child: child,
          //                     ),
          //                   ),
          //                 );
          //               },
          //               child: Text(
          //                 'See All',
          //                 style: Styles.regularPoppins12
          //                     .copyWith(decoration: TextDecoration.underline),
          //               ),
          //             )
          //           ],
          //         ),
          //         SizedBox(
          //           height: 12.h,
          //         ),
          //       ],
          //     ),
          //   ),
          // BlocProvider(
          //   create: (context) =>
          //       GetArticlesCubit(getIt<ShowMediaRepo>())..getArticles(),
          //   child: ArticleListBlocBuilder(
          //     onEmptyList: () => setState(() => _showArticleHeader = false),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.h,
                ),
                const Text('Recently Added', style: Styles.semiBoldPoppins20),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) => RecentlyAddedCubit(getIt<RecentlyAddedRepo>())
              ..getRecentlyAddedVideos(),
            child: const RecentlyAddedBlocBuilder(),
          ),
        ],
      ),
    );
  }
}
