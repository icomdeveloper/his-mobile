import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/profile/presentation/cubits/user_videos_cubit/user_videos_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/declined_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/in_review_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/published_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/revise_tab_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MyVideosViewBody extends StatefulWidget {
  const MyVideosViewBody({super.key});

  @override
  State<MyVideosViewBody> createState() => _MyVideosViewBodyState();
}

class _MyVideosViewBodyState extends State<MyVideosViewBody>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('my-videos-view-body'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          context.read<UserVideosCubit>().userVideos();
        }
      },
      child: BlocBuilder<UserVideosCubit, UserVideosState>(
        builder: (context, state) {
          if (state is GetUserVideosFailure) {
            return Center(
              child: CustomErrorWidget(
                errorMessage: state.errMessage,
                onTap: () {
                  context.read<UserVideosCubit>().userVideos();
                },
              ),
            );
          } else if (state is GetUserVideosSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TabBar(
                    controller: tabController,
                    tabs: const [
                      Tab(
                        text: 'Published',
                      ),
                      Tab(
                        text: 'Pending',
                      ),
                      Tab(
                        text: 'In Review',
                      ),
                      Tab(
                        text: 'Revise',
                      ),
                      Tab(
                        text: 'Reclined',
                      ),
                    ],
                    labelColor: const Color(0xff0F0F0F),
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorColor: const Color(0xff0F0F0F),
                    unselectedLabelColor: AppColors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: Styles.semiBoldPoppins14,
                    unselectedLabelStyle: Styles.semiBoldPoppins14,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 20),
                    dividerColor: AppColors.lightGrey,
                    dividerHeight: 1,
                    indicatorWeight: 2,
                  ),
                  Expanded(
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: tabController,
                          children: [
                        // MultiBlocProvider(
                        //   providers: [
                        //     BlocProvider(
                        //       create: (context) =>
                        //           UploadMediaCubit(getIt<UploadVideoRepo>()),
                        //     ),
                        //     BlocProvider(
                        //       create: (context) =>
                        //           CategoriesCubit(getIt<CategoriesRepo>())
                        //             ..getCategories(),
                        //     ),
                        //     BlocProvider(
                        //       create: (context) =>
                        //           GetUsersCubit(getIt<GetUsersRepo>())..getUsers(),
                        //     ),
                        //   ],
                        //   child: const UploadVideoTab(),
                        // ),
                        PublishedTabBar(
                            mediaList: state.mediaMap['published'] ?? []),
                        PendingTabBar(
                            mediaList: state.mediaMap['pending'] ?? []),
                        InReviewTabBar(
                            mediaList: state.mediaMap['in_review'] ?? []),
                        ReviseTabBar(mediaList: state.mediaMap['revise'] ?? []),
                        DeclinedTabBar(
                            mediaList: state.mediaMap['declined'] ?? [])
                      ])),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
