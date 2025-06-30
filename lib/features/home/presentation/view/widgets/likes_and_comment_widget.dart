import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/likes_manager.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/home/data/repo/media_likes_repo.dart';
import 'package:his/features/home/presentation/cubits/media_likes_cubit/media_likes_cubit.dart';

import '../../../../../core/services/get_it.dart';

class LikesAndCommentsWidget extends StatelessWidget {
  const LikesAndCommentsWidget({
    super.key,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.mediaId,
  });
  final int numberOfLikes, numberOfComments, mediaId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaLikesCubit(getIt<MediaLikesRepo>()),
      child: LikesAndComments(
          numberOfLikes: numberOfLikes,
          numberOfComments: numberOfComments,
          mediaId: mediaId),
    );
  }
}

class LikesAndComments extends StatefulWidget {
  const LikesAndComments({
    super.key,
    required this.numberOfLikes,
    required this.numberOfComments,
    required this.mediaId,
  });

  final int numberOfLikes;
  final int numberOfComments;
  final int mediaId;

  @override
  State<LikesAndComments> createState() => _LikesAndCommentsState();
}

class _LikesAndCommentsState extends State<LikesAndComments> {
  bool _isLiked = false;
  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
  }

  Future<void> _loadLikeStatus() async {
    final isLiked = await LikesManager.isLiked(widget.mediaId);
    setState(() {
      _isLiked = isLiked;
    });
  }

  Future<void> _toggleLike() async {
    await LikesManager.toggleLike(widget.mediaId);
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      InkWell(
        onTap: () {
          if (!_isLiked) {
            BlocProvider.of<MediaLikesCubit>(context)
                .addLike(mediaId: widget.mediaId);
          } else {
            BlocProvider.of<MediaLikesCubit>(context)
                .deleteLike(mediaId: widget.mediaId);
          }
          _toggleLike();
        },
        child: Icon(
          _isLiked ? Icons.favorite : Icons.favorite_border_outlined,
          size: 18,
          color: _isLiked ? AppColors.primaryColor : AppColors.darkGrey,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        _isLiked
            ? '${widget.numberOfLikes + 1} Like'
            : '${widget.numberOfLikes} Like',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
      const SizedBox(
        width: 24,
      ),
      SvgPicture.asset(Assets.assetsImagesComment),
      const SizedBox(
        width: 4,
      ),
      Text(
        '${widget.numberOfComments} Comments',
        style: Styles.semiBoldRoboto12.copyWith(color: AppColors.darkGrey),
      ),
    ]);
  }
}
