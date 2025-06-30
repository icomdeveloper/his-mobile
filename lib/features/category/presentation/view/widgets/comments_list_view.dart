import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/presentation/view/widgets/comment_widget.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:his/features/home/presentation/cubits/comment_likes_cubit/comment_like_cubit.dart';

import '../../../../home/data/repo/media_likes_repo.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView(
      {super.key, required this.comments, this.isDummy = false});
  final List<CommentsModel> comments;
  final bool isDummy;

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    _scrollToBottom();
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
    controller.dispose();
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
              '${widget.comments.length} Comments',
              style: Styles.regularRoboto12.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        BlocProvider(
          create: (context) => CommentLikeCubit(getIt<MediaLikesRepo>()),
          child: Expanded(
            child: ListView.separated(
              controller: controller,
              separatorBuilder: (context, index) => const Divider(
                color: AppColors.lightGrey,
              ),
              itemCount: commentsList.length,
              itemBuilder: (context, index) => CommentWidget(
                comment: commentsList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _scrollToBottom() {
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
}

List<CommentsModel> commentsList = [];
