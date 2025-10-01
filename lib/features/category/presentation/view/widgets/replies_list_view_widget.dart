import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/presentation/cubits/delete_comment_cubit/delete_comment_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/reply_widget.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';
import 'package:his/features/home/data/models/comments_model/reply_model.dart';
import 'package:his/features/home/data/repo/media_likes_repo.dart';
import 'package:his/features/home/presentation/cubits/comment_likes_cubit/comment_like_cubit.dart';

class RepliesListViewWidget extends StatefulWidget {
  const RepliesListViewWidget({
    super.key,
    required this.replies,
    required this.controller,
    required this.commentIndex,
    this.onCommentDeleted,
  });
  final ScrollController controller;
  final List<ReplyModel>? replies;
  final int commentIndex;
  final ValueChanged<int>? onCommentDeleted;

  @override
  State<RepliesListViewWidget> createState() => _RepliesListViewWidgetState();
}

class _RepliesListViewWidgetState extends State<RepliesListViewWidget> {
  bool showMoreReplies = false;

  @override
  void initState() {
    // repliesList.clear();
    // for (var reply in widget.replies!) {
    //   repliesList[reply.parentId]!.add(reply);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.replies != null && widget.replies!.isNotEmpty)
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: showMoreReplies ? widget.replies!.length : 1,
            itemBuilder: (context, index) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        CommentLikeCubit(getIt<MediaLikesRepo>()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        DeleteCommentCubit(getIt<CommentRepo>()),
                  ),
                ],
                child: ReplyWidget(
                  reply: widget.replies![index],
                  index: index,
                  onDeleteReply: (deleted) {
                    setState(() {
                      if (commentsList[widget.commentIndex]
                                  .replies?[index]
                                  .secondReplies !=
                              null &&
                          commentsList[widget.commentIndex]
                              .replies![index]
                              .secondReplies!
                              .isNotEmpty) {
                        commentsCount = commentsCount -
                            1 -
                            commentsList[widget.commentIndex]
                                .replies![index]
                                .secondReplies!
                                .length;
                      } else {
                        commentsCount = commentsCount - 1;
                      }

                      widget.onCommentDeleted?.call(commentsCount);
                    });
                  },
                ),
              );
            }),
      if (widget.replies != null && widget.replies!.length > 1)
        GestureDetector(
          onTap: () {
            setState(() {
              showMoreReplies = !showMoreReplies;
              log("length of comment list ==> ${commentsList.length}");
              log("comment index ==> ${widget.commentIndex}");

              if (widget.commentIndex >= (commentsList.length - 1)) {
                widget.controller.animateTo(
                    widget.controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              }
            });
          },
          child: Text(
            showMoreReplies
                ? 'Hide ${widget.replies!.length - 1} reply'
                : 'Show ${widget.replies!.length - 1} reply',
            style: Styles.semiBoldPoppins12.copyWith(
              fontSize: 11,
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      const SizedBox(
        height: 12,
      )
    ]);
  }
}

Map<int, List<ReplyModel>> repliesList = {};
