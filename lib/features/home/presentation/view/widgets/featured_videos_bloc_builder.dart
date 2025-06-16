import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/helpers/dummy_media.dart';
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
          return CarouselSlider.builder(
            itemCount: state.mediaList.length,
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 0.95,
              autoPlay: true,
              // height: mediaQuery.size.height * 0.42,
            ),
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
          return Center(child: Text(state.errMessage));
        } else {
          return Skeletonizer(
              child: CarouselSlider.builder(
            itemCount: dummyMediaList.length,
            options: CarouselOptions(
              viewportFraction: 1,
              aspectRatio: 0.95,
              autoPlay: true,
              // height: mediaQuery.size.height * 0.42,
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
