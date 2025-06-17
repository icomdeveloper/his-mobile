import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:his/features/home/data/repo/featured_videos_repo.dart';
import 'package:his/features/home/data/repo/recently_added_repo.dart';
import 'package:his/features/home/presentation/cubits/featured_videos_cubit/featured_videos_cubit.dart';
import 'package:his/features/home/presentation/cubits/get_articles_cubit/get_articles_cubit.dart';
import 'package:his/features/home/presentation/cubits/recently_added_cubit/recently_added_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/article_list_bloc_builder.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_field.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_bloc_builder.dart';
import 'package:his/features/home/presentation/view/widgets/recently_added_bloc_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });
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
                const CustomTextField(
                  hintText: 'Search..',
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                const Text('Featured Videos', style: Styles.semiBoldRoboto20),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              create: (context) =>
                  FeaturedVideosCubit(getIt<FeaturedVideosRepo>())
                    ..getFeaturedVideos(),
              child: const FeaturedVideosBlocBuilder(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 12.h,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(
                  height: 32.h,
                ),
                const Text('Articles', style: Styles.semiBoldRoboto20),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) =>
                GetArticlesCubit(getIt<ShowMediaRepo>())..getArticles(),
            child: const ArticleListBlocBuilder(),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                const Text('Recently Added', style: Styles.semiBoldRoboto20),
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
