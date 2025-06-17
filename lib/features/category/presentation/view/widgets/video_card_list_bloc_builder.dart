import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/category/presentation/cubits/get_media_cubit/get_media_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_sliver_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideoCardListBlocBuilder extends StatelessWidget {
  const VideoCardListBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMediaCubit, GetMediaState>(
      builder: (context, state) {
        if (state is GetMediaSuccess) {
          return VideoCardSliverList(
            mediaList: state.mediaList,
          );
        } else if (state is GetMediaFailure) {
          return SliverToBoxAdapter(
              child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: CustomErrorWidget(
              errorMessage: state.message,
              onTap: () {
                context.read<GetMediaCubit>().getMedia();
              },
            ),
          ));
        } else {
          return Skeletonizer.sliver(
              child: VideoCardSliverList(
            mediaList: dummyMediaList,
          ));
        }
      },
    );
  }
}
