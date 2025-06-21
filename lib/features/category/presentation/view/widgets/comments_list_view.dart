import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/presentation/view/widgets/comment_widget.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';

class CommentsListView extends StatefulWidget {
  const CommentsListView({super.key, required this.comments});
  final List<CommentsModel> comments;

  @override
  State<CommentsListView> createState() => _CommentsListViewState();
}

class _CommentsListViewState extends State<CommentsListView> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    _scrollToBottom();
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
        Expanded(
          child: ListView.separated(
            controller: controller,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.lightGrey,
            ),
            itemCount: widget.comments.length,
            itemBuilder: (context, index) => CommentWidget(
              comment: widget.comments[index],
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
