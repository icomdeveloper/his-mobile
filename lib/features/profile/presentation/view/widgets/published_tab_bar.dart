import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/profile/presentation/cubits/user_videos_cubit/user_videos_cubit.dart';

import 'package:his/features/profile/presentation/view/widgets/approved_video_sliver_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PublishedTabBar extends StatelessWidget {
  const PublishedTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        BlocBuilder<UserVideosCubit, UserVideosState>(
          builder: (context, state) {
            if (state is GetUserVideosFailure) {
              return SliverToBoxAdapter(
                  child: SizedBox(
                      height: 150,
                      child: CustomErrorWidget(
                        errorMessage: state.errMessage,
                        onTap: () {
                          context.read<UserVideosCubit>().userVideos();
                        },
                      )));
            } else if (state is GetUserVideosSuccess) {
              if (state.mediaList.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'You have no videos yet',
                      style: Styles.semiBoldPoppins14,
                    ),
                  ),
                );
              }
              return ApprovedVideosSliverList(
                mediaList: state.mediaList,
              );
            } else {
              return Skeletonizer.sliver(
                  child: ApprovedVideosSliverList(
                mediaList: dummyMediaList,
              ));
            }
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24))
      ],
    );
  }
}
