import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/cubit/recently_added_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/articles_sliver_list.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_field.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_item.dart';
import 'package:his/features/home/presentation/view/widgets/recently_added_sliver_list.dart';

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
            child: CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 0.95,
                autoPlay: true,
                // height: mediaQuery.size.height * 0.42,
              ),
              itemBuilder: (context, index, realIndex) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: FeaturedVideosItem(),
                );
              },
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
          const ArticlesSliverList(),
          // SliverToBoxAdapter(
          //     child: Row(
          //   children: [
          //     // const Text('Recommended Videos', style: Styles.semiBoldRoboto20),
          //     const Spacer(),
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => const LoginView(),
          //         ));
          //       },
          //       child: Text('See All',
          //           style: Styles.regularRoboto12
          //               .copyWith(color: AppColors.primaryColor)),
          //     ),
          //   ],
          // )),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 12.h,
          //   ),
          // ),
          // const RecommendedVideosSliverGrid(),
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
          BlocBuilder<RecentlyAddedCubit, RecentlyAddedState>(
            builder: (context, state) {
              if (state is RecentlyAddedSuccess) {
                return RecentlyAddedSliverList(
                  recentlyAdded: state.mediaList,
                );
              }
              if (state is RecentlyAddedFailure) {
                return SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Center(child: Text(state.errMessage)),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ));
              } else {
                return const SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
