import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    this.onLikeChanged,
    required this.isLiked,
  });
  final int numberOfLikes, numberOfComments, mediaId;
  final bool isLiked;
  final ValueChanged<bool>? onLikeChanged;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaLikesCubit(getIt<MediaLikesRepo>()),
      child: LikesAndComments(
          isLiked: isLiked,
          onLikeChanged: (value) {
            onLikeChanged?.call(value);
          },
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
    this.onLikeChanged,
    required this.isLiked,
  });

  final int numberOfLikes;
  final int numberOfComments;
  final int mediaId;
  final bool isLiked;
  final ValueChanged<bool>? onLikeChanged;

  @override
  State<LikesAndComments> createState() => _LikesAndCommentsState();
}

class _LikesAndCommentsState extends State<LikesAndComments> {
  bool _isLiked = false;
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
        },
        child: BlocListener<MediaLikesCubit, MediaLikesState>(
          listener: (context, state) {
            if (state is AddLikeSuccess) {
              _isLiked = true;
              widget.onLikeChanged?.call(true);
            }
            if (state is DeleteLikeSuccess) {
              _isLiked = false;
              widget.onLikeChanged?.call(false);
            }
            if (state is AddLikeFailure) {
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is DeleteLikeFailure) {
              Fluttertoast.showToast(msg: state.message);
            }
            setState(() {});
          },
          child: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            size: 18,
            color: _isLiked ? AppColors.primaryColor : AppColors.darkGrey,
          ),
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Text(
        widget.numberOfLikes > 1
            ? '${widget.numberOfLikes} Likes'
            : '${widget.numberOfLikes} Like',
        style: Styles.semiBoldPoppins12.copyWith(color: AppColors.darkGrey),
      ),
      const SizedBox(
        width: 24,
      ),
      SvgPicture.asset(Assets.assetsImagesComment),
      const SizedBox(
        width: 4,
      ),
      Text(
        widget.numberOfComments > 1
            ? '${widget.numberOfComments} Comments'
            : '${widget.numberOfComments} Comment',
        style: Styles.semiBoldPoppins12.copyWith(color: AppColors.darkGrey),
      ),
    ]);
  }
}
