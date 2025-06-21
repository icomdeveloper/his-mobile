import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/presentation/view/widgets/reply_widget.dart';
import 'package:his/features/home/data/models/comments_model/reply_model.dart';

class RepliesListViewWidget extends StatefulWidget {
  const RepliesListViewWidget({
    super.key,
    required this.replies,
  });

  final List<ReplyModel>? replies;

  @override
  State<RepliesListViewWidget> createState() => _RepliesListViewWidgetState();
}

class _RepliesListViewWidgetState extends State<RepliesListViewWidget> {
  bool showMoreReplies = false;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.replies != null && widget.replies!.isNotEmpty)
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: showMoreReplies ? widget.replies!.length : 1,
            itemBuilder: (context, index) {
              return ReplyWidget(reply: widget.replies![index]);
            }),
      if (widget.replies != null && widget.replies!.length > 1)
        GestureDetector(
          onTap: () {
            setState(() {
              showMoreReplies = !showMoreReplies;
            });
          },
          child: Text(
            showMoreReplies ? 'Less replies' : 'More replies',
            style: Styles.semiBoldInter14.copyWith(
              fontSize: 10,
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
    ]);
  }
}
