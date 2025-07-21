import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:his/features/category/presentation/cubits/add_comments_cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/get_comments_cubit/get_comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/media_details_cubit/media_details_cubit.dart';
import 'package:his/features/category/presentation/cubits/views_cubit/views_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';
import 'package:his/features/profile/data/repo/edit_media_repo.dart';
import 'package:his/features/profile/presentation/cubits/edit_media_cubit/edit_media_cubit.dart';
import 'package:his/features/profile/presentation/view/edit_video_view.dart';

class VideoViewBody extends StatelessWidget {
  const VideoViewBody({
    super.key,
    required this.mediaModel,
    // required this.likesCount,
  });
  final MediaModel mediaModel;
  // final int likesCount;
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
              pageBuilder: (_, __, ___) => BlocProvider(
                create: (context) => EditMediaCubit(getIt<EditMediaRepo>()),
                child: EditVideoView(
                  mediaModel: mediaModel,
                ),
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
              create: (context) => ViewsCubit(getIt<ShowMediaRepo>()),
            ),
            BlocProvider(
              create: (context) => GetCommentsCubit(getIt<CommentRepo>())
                ..getComments(
                    mediaId: mediaModel.id!,
                    isPending: mediaModel.status == 'pending'),
            ),
          ],
          child: BlocBuilder<MediaDetailsCubit, MediaDetailsState>(
            builder: (context, state) {
              if (state is MediaDetailsSuccess) {
                return VideoWidget(
                  mediaModel: state.mediaModel,
                  // likesCount: likesCount,
                );
              } else if (state is MediaDetailsFailure) {
                return Center(
                  child: CustomErrorWidget(
                    errorMessage: state.errMesage,
                    onTap: () {
                      context
                          .read<MediaDetailsCubit>()
                          .getMediaDetails(mediaId: mediaModel.id!);
                    },
                  ),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ));
            },
          ),
        ),
      ),
    );
  }
}
