import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/presentation/cubits/add_comments_cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/get_comments_cubit/get_comments_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';
import 'package:his/features/profile/presentation/view/edit_video_view.dart';

class VideoView extends StatelessWidget {
  const VideoView({
    super.key,
    required this.mediaModel,
    required this.likesCount,
  });
  final MediaModel mediaModel;
  final int likesCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(
        context,
        title: mediaModel.title ?? "",
        isEditAppear: mediaModel.status == 'pending' ? true : false,
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => EditVideoView(
                mediaModel: mediaModel,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CommentsCubit(getIt<CommentRepo>()),
            ),
            BlocProvider(
              create: (context) => GetCommentsCubit(getIt<CommentRepo>())
                ..getComments(mediaId: mediaModel.id!),
            ),
          ],
          child: VideoWidget(
            mediaModel: mediaModel,
            likesCount: likesCount,
          ),
        ),
      ),
    );
  }
}
