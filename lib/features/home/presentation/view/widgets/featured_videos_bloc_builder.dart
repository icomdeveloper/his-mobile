import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/home/presentation/cubits/featured_videos_cubit/featured_videos_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeaturedVideosBlocBuilder extends StatelessWidget {
  const FeaturedVideosBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedVideosCubit, FeaturedVideosState>(
      builder: (context, state) {
        if (state is FeaturedVideosSuccess) {
          if (state.mediaList.isEmpty) return const SizedBox.shrink();

          return SizedBox(
            height: 338.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemCount: state.mediaList.length,
              itemBuilder: (context, index) => FeaturedVideosItem(
                mediaModel: state.mediaList[index],
              ),
            ),
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
        }

        // Loading state (Skeletons)
        return SizedBox(
          height: 338.h,
          child: Skeletonizer(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemCount: dummyMediaList.length,
              itemBuilder: (context, index) => FeaturedVideosItem(
                mediaModel: dummyMediaList[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
