import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/presentation/cubits/delete_comment_cubit/delete_comment_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comment_widget.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:his/features/home/presentation/cubits/comment_likes_cubit/comment_like_cubit.dart';

import '../../../../home/data/repo/media_likes_repo.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView(
      {super.key,
      required this.comments,
      this.isDummy = false,
      required this.status,
      required this.commentsCount,
      required this.controller,
      this.onCommentDeleted});
  final List<CommentsModel> comments;
  final bool isDummy;
  final String status;
  final int commentsCount;
  final ScrollController controller;
  final ValueChanged<int>? onCommentDeleted;
  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  @override
  void initState() {
    scrollToBottom(controller: widget.controller);
    if (!widget.isDummy) {
      commentsList.clear();

      for (var comment in widget.comments) {
        commentsList.add(comment);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Comments',
              style: Styles.semiBoldPoppins14,
            ),
            Text(
              '$commentsCount Comments',
              style: Styles.semiBoldPoppins12.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView.separated(
            controller: widget.controller,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.lightGrey,
            ),
            itemCount: commentsList.length,
            itemBuilder: (context, index) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      CommentLikeCubit(getIt<MediaLikesRepo>()),
                ),
              ],
              child: BlocProvider(
                create: (context) => DeleteCommentCubit(getIt<CommentRepo>()),
                child: CommentWidget(
                  commentIndex: index,
                  controller: widget.controller,
                  status: widget.status,
                  comment: commentsList[index],
                  onCommentDeleted: (value) {
                    setState(() {
                      widget.onCommentDeleted?.call(value);
                    });
                  },
                  onDeleteComment: (value) {
                    setState(() {
                      if (commentsList[index].replies != null &&
                          commentsList[index].replies!.isNotEmpty) {
                        commentsCount = commentsCount -
                            1 -
                            commentsList[index].replies!.length;
                      } else {
                        commentsCount = commentsCount - 1;
                      }
                      commentsList.removeAt(index);
                      widget.onCommentDeleted?.call(commentsCount);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void scrollToBottom({required ScrollController controller}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  });
}
