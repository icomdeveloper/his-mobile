import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
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
    this.isLiked,
    this.isInVideoView = false,
    this.isPending = false,
  });
  final int numberOfLikes, numberOfComments, mediaId;
  final bool? isLiked;
  final ValueChanged<bool>? onLikeChanged;
  final bool isInVideoView;
  final bool isPending;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MediaLikesCubit(getIt<MediaLikesRepo>()),
      child: LikesAndComments(
          isLiked: isLiked ?? false,
          onLikeChanged: (value) {
            onLikeChanged?.call(value);
          },
          numberOfLikes: numberOfLikes,
          numberOfComments: numberOfComments,
          isInVideoView: isInVideoView,
          isPending: isPending,
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
    required this.isInVideoView,
    this.isPending = false,
  });

  final int numberOfLikes;
  final int numberOfComments;
  final int mediaId;
  final bool isLiked;
  final ValueChanged<bool>? onLikeChanged;
  final bool isInVideoView;
  final bool isPending;
  @override
  State<LikesAndComments> createState() => _LikesAndCommentsState();
}

class _LikesAndCommentsState extends State<LikesAndComments> {
  late bool _isLiked;
  late int _likesCount;
  @override
  initState() {
    _isLiked = widget.isLiked;
    _likesCount = widget.numberOfLikes;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      widget.isPending
          ? const SizedBox.shrink()
          : InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (!Prefs.getBool(PrefsKeys.isLoggedIn)) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                  );
                  return;
                }
                if (!_isLiked) {
                  BlocProvider.of<MediaLikesCubit>(context)
                      .addLike(mediaId: widget.mediaId);
                } else {
                  BlocProvider.of<MediaLikesCubit>(context)
                      .deleteLike(mediaId: widget.mediaId);
                }
              },
              child: Row(
                children: [
                  BlocListener<MediaLikesCubit, MediaLikesState>(
                    listener: (context, state) {
                      if (state is AddLikeSuccess) {
                        _isLiked = true;
                        widget.onLikeChanged?.call(true);
                        _likesCount++;
                      }
                      if (state is DeleteLikeSuccess) {
                        _isLiked = false;
                        widget.onLikeChanged?.call(false);
                        _likesCount--;
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
                      _isLiked
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 18,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    _likesCount > 1
                        ? '$_likesCount Likes'
                        : '$_likesCount Like',
                    style: Styles.semiBoldPoppins12
                        .copyWith(color: AppColors.darkGrey),
                  ),
                ],
              ),
            ),
      widget.isPending
          ? const SizedBox.shrink()
          : const SizedBox(
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
        // widget.numberOfComments > 1
        //     ? '${widget.numberOfComments} Comments'
        //     : '${widget.numberOfComments} Comment',
        style: Styles.semiBoldPoppins12.copyWith(color: AppColors.darkGrey),
      ),
    ]);
  }
}
