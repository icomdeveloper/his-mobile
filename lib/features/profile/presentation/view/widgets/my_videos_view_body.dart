import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/repo/categories_repo.dart';
import 'package:his/features/category/presentation/cubits/categories_cubit/categories_cubit.dart';
import 'package:his/features/profile/data/repo/upload_video_repo.dart';
import 'package:his/features/profile/data/repo/user_videos_repo.dart';
import 'package:his/features/profile/presentation/cubits/upload_media_cubit/upload_media_cubit.dart';
import 'package:his/features/profile/presentation/cubits/user_videos_cubit/user_videos_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/published_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/upload_video_tab.dart';

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
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: 'Upload',
              ),
              Tab(
                text: 'Published',
              ),
              Tab(
                text: 'Pending',
              ),
            ],
            labelColor: const Color(0xff0F0F0F),
            physics: const NeverScrollableScrollPhysics(),
            indicatorColor: const Color(0xff0F0F0F),
            unselectedLabelColor: AppColors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Styles.semiBoldPoppins14,
            unselectedLabelStyle: Styles.semiBoldPoppins14,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            dividerColor: AppColors.lightGrey,
            dividerHeight: 1,
            indicatorWeight: 2,
          ),
          Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          UploadMediaCubit(getIt<UploadVideoRepo>()),
                    ),
                    BlocProvider(
                      create: (context) =>
                          CategoriesCubit(getIt<CategoriesRepo>())
                            ..getCategories(),
                    ),
                  ],
                  child: const UploadVideoTab(),
                ),
                BlocProvider(
                  create: (context) =>
                      UserVideosCubit(getIt<UserVideosRepo>())..userVideos(),
                  child: const PublishedTabBar(),
                ),
                BlocProvider(
                    create: (context) =>
                        UserVideosCubit(getIt<UserVideosRepo>())
                          ..userPendingVideos(),
                    child: const PendingTabBar()),
              ]))
        ],
      ),
    );
  }
}
