import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/media_details_repo.dart';
import 'package:his/features/category/presentation/cubits/media_details_cubit/media_details_cubit.dart';
import 'package:his/features/home/presentation/cubits/featured_videos_cubit/featured_videos_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/video_view_body.dart';

class VideoView extends StatelessWidget {
  const VideoView({
    super.key,
    required this.mediaModel,
    this.videoType = '',
    // required this.likesCount,
  });
  final MediaModel mediaModel;
  static const routeName = '/videoView';
  final String videoType;
  // final int likesCount;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (videoType == 'featured') {
            BlocProvider.of<FeaturedVideosCubit>(context).getFeaturedVideos();
          }
        }
      },
      child: BlocProvider(
        create: (context) => MediaDetailsCubit(getIt<MediaDetailsRepo>())
          ..getMediaDetails(mediaId: mediaModel.id ?? 0),
        child: VideoViewBody(
          mediaModel: mediaModel,
          // likesCount: likesCount,
        ),
      ),
    );
  }
}
