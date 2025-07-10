import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/cubits/featured_videos_cubit/featured_videos_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/featured_videos_bloc_builder.dart';

class FeaturedVideos extends StatefulWidget {
  const FeaturedVideos({
    super.key,
  });

  @override
  State<FeaturedVideos> createState() => _FeaturedVideosState();
}

class _FeaturedVideosState extends State<FeaturedVideos> {
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<FeaturedVideosCubit, FeaturedVideosState>(
      listener: (context, state) {
        if (state is FeaturedVideosSuccess) {
          if (state.mediaList.isEmpty) {
            setState(() {
              isEmpty = true;
            });
          }
        }
      },
      child: isEmpty
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                const Text('Featured Videos', style: Styles.semiBoldPoppins20),
                SizedBox(
                  height: 12.h,
                ),
                const FeaturedVideosBlocBuilder(),
              ],
            ),
    );
  }
}
