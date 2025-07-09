import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/profile/presentation/cubits/user_videos_cubit/user_videos_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/pending_video_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PendingTabBar extends StatelessWidget {
  const PendingTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        BlocBuilder<UserVideosCubit, UserVideosState>(
          builder: (context, state) {
            if (state is GetPendingSuccess) {
              if (state.mediaList.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'You have no pending videos',
                      style: Styles.semiBoldPoppins14,
                    ),
                  ),
                );
              }
              return PendingVideosSliverList(
                mediaList: state.mediaList,
              );
            } else if (state is GetPendingFailure) {
              return SliverToBoxAdapter(
                  child: SizedBox(
                      height: 150,
                      child: CustomErrorWidget(
                        errorMessage: state.errMessage,
                        onTap: () {
                          context.read<UserVideosCubit>().userPendingVideos();
                        },
                      )));
            } else {
              return Skeletonizer.sliver(
                  child: PendingVideosSliverList(
                mediaList: dummyMediaList,
              ));
            }
          },
        ),
        const SliverToBoxAdapter(
          child: Divider(
            color: AppColors.lightGrey,
            height: 32,
          ),
        ),
      ],
    );
  }
}
