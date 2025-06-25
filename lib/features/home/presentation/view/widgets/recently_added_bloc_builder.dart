import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/home/presentation/cubits/recently_added_cubit/recently_added_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/recently_added_sliver_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RecentlyAddedBlocBuilder extends StatelessWidget {
  const RecentlyAddedBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentlyAddedCubit, RecentlyAddedState>(
      builder: (context, state) {
        if (state is RecentlyAddedSuccess) {
          if (state.mediaList.isEmpty) {
            return SliverToBoxAdapter(
                child: SizedBox(
                    height: 150,
                    child: CustomErrorWidget(
                      errorMessage: 'No videos found ',
                      onTap: () {
                        context
                            .read<RecentlyAddedCubit>()
                            .getRecentlyAddedVideos();
                      },
                    )));
          }
          return RecentlyAddedSliverList(
            recentlyAdded: state.mediaList,
          );
        }
        if (state is RecentlyAddedFailure) {
          return SliverToBoxAdapter(
              child: SizedBox(
                  height: 150,
                  child: CustomErrorWidget(
                    errorMessage: state.errMessage,
                    onTap: () {
                      context
                          .read<RecentlyAddedCubit>()
                          .getRecentlyAddedVideos();
                    },
                  )));
        } else {
          return Skeletonizer.sliver(
              child: RecentlyAddedSliverList(
            recentlyAdded: dummyMediaList,
          ));
        }
      },
    );
  }
}
