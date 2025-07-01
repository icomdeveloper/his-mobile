import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/home/presentation/cubits/featured_videos_cubit/featured_videos_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeaturedVideosBlocBuilder extends StatelessWidget {
  const FeaturedVideosBlocBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedVideosCubit, FeaturedVideosState>(
      builder: (context, state) {
        if (state is FeaturedVideosSuccess) {
          if (state.mediaList.isEmpty) {
            return const SizedBox.shrink();
          }
          return CarouselSlider.builder(
            itemCount: state.mediaList.length,
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                aspectRatio: 342.w / 340.h),
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FeaturedVideosItem(
                  mediaModel: state.mediaList[index],
                ),
              );
            },
          );
        }
        if (state is FeaturedVideosFailure) {
          return SizedBox(
            height: 200.h,
            child: Center(
              child: AspectRatio(
                aspectRatio: 342.w / 340.h,
                child: CustomErrorWidget(
                  errorMessage: state.errMessage,
                  onTap: () {
                    context.read<FeaturedVideosCubit>().getFeaturedVideos();
                  },
                ),
              ),
            ),
          );
        } else {
          return Skeletonizer(
              child: CarouselSlider.builder(
            itemCount: dummyMediaList.length,
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 342.w / 340.h,
              autoPlay: true,
            ),
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FeaturedVideosItem(
                  mediaModel: dummyMediaList[index],
                ),
              );
            },
          ));
        }
      },
    );
  }
}
