import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/calculate_time_ago.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/category/presentation/cubits/add_comments_cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comment_text_field.dart';
import 'package:his/features/category/presentation/view/widgets/replies_list_view_widget.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:his/features/home/presentation/cubits/comment_likes_cubit/comment_like_cubit.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.comment,
  });
  final CommentsModel comment;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showReplyTextField = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final UserInformation userInformation = widget.comment.user!;
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundImage: const CachedNetworkImageProvider(
                'https://i.pravatar.cc/300?img=1'),
            radius: 20.r,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userInformation.name!,
                style: Styles.semiBoldRoboto12,
              ),
              Text(getRelativeTime(widget.comment.createdAt!),
                  style: Styles.regularRoboto12)
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    child: Text(
                      widget.comment.content!,
                      style: Styles.regularRoboto12,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (isLiked) {
                        context
                            .read<CommentLikeCubit>()
                            .deleteLike(commentId: widget.comment.id!);
                      } else {
                        context
                            .read<CommentLikeCubit>()
                            .addLike(commentId: widget.comment.id!);
                      }
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                      size: 18,
                      color:
                          isLiked ? AppColors.primaryColor : AppColors.darkGrey,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showReplyTextField = !showReplyTextField;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.assetsImagesReply),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Reply',
                      style: Styles.regularRoboto12,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.comment.replies?.isEmpty ?? true
                  ? const SizedBox.shrink()
                  : RepliesListViewWidget(
                      replies: widget.comment.replies,
                    ),
              showReplyTextField
                  ? CommentTextField(
                      autofocus: true,
                      controller: context.read<CommentsCubit>().replyController,
                      onTap: () {
                        context.read<CommentsCubit>().addReply(
                            mediaId: widget.comment.mediaId!,
                            parentId: widget.comment.id!);
                      })
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
