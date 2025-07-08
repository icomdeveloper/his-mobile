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
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: state.mediaList.length,
            itemBuilder: (
              context,
              index,
            ) {
              return FeaturedVideosItem(
                mediaModel: state.mediaList[index],
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
              child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: dummyMediaList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (
              context,
              index,
            ) {
              return FeaturedVideosItem(
                mediaModel: dummyMediaList[index],
              );
            },
          ));
        }
      },
    );
  }
}
