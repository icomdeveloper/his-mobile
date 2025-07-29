import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/media_details_repo.dart';
import 'package:his/features/category/presentation/cubits/media_details_cubit/media_details_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/video_view_body.dart';

class VideoView extends StatelessWidget {
  const VideoView({
    super.key,
    required this.mediaModel,
    // required this.likesCount,
  });
  final MediaModel mediaModel;
  // final int likesCount;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaDetailsCubit(getIt<MediaDetailsRepo>())
        ..getMediaDetails(mediaId: mediaModel.id ?? 0),
      child: VideoViewBody(
        mediaModel: mediaModel,
        // likesCount: likesCount,
      ),
    );
  }
}
