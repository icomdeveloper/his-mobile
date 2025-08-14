import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:his/features/bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_widget.dart';

class VideoCardSliverList extends StatefulWidget {
  const VideoCardSliverList({
    super.key,
    required this.mediaList,
    this.isFavourite,
    this.isFromBookmarks = false,
    this.isDummy = false,
  });
  final List<MediaModel> mediaList;
  final bool? isFavourite;
  final bool isFromBookmarks;
  final bool isDummy;

  @override
  State<VideoCardSliverList> createState() => _VideoCardSliverListState();
}

class _VideoCardSliverListState extends State<VideoCardSliverList> {
  @override
  void initState() {
    if (!widget.isDummy) {
      customMediaList.clear();

      for (var mediaModel in widget.mediaList) {
        customMediaList.add(mediaModel);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: widget.isFromBookmarks
          ? customMediaList.length
          : widget.mediaList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => BlocProvider(
        create: (context) => BookmarksCubit(getIt<BookmarksRepo>()),
        child: VideoCardWidget(
          isFrombookmarks: widget.isFromBookmarks,
          mediaModel: widget.isFromBookmarks
              ? customMediaList[index]
              : widget.mediaList[index],
          isbookmark:
              widget.isFavourite ?? widget.mediaList[index].isFavorite ?? false,
          onRemoveBookmark: (value) {
            setState(() {
              customMediaList.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}

List<MediaModel> customMediaList = [];
