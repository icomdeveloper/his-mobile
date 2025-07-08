import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:his/features/bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class VideoCardSliverList extends StatelessWidget {
  const VideoCardSliverList({
    super.key,
    required this.mediaList,
    this.isFavourite,
  });
  final List<MediaModel> mediaList;
  final bool? isFavourite;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: mediaList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => BlocProvider(
        create: (context) => BookmarksCubit(getIt<BookmarksRepo>()),
        child: VideoCardWidget(
          mediaModel: mediaList[index],
          isbookmark: isFavourite ?? mediaList[index].isFavorite ?? false,
        ),
      ),
    );
  }
}
