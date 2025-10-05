import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/calculate_time_ago.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/helpers/images_format.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/category/presentation/cubits/comments_cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/delete_comment_cubit/delete_comment_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comment_text_field.dart';
import 'package:his/features/category/presentation/view/widgets/replies_list_view_widget.dart';
import 'package:his/features/home/data/models/comments_model/comments_model.dart';
import 'package:his/features/home/presentation/cubits/comment_likes_cubit/comment_like_cubit.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.status,
    this.onDeleteComment,
    required this.controller,
    required this.commentIndex,
    this.onCommentDeleted,
  });
  final CommentsModel comment;
  final int commentIndex;
  final String status;
  final ValueChanged<bool>? onDeleteComment;
  final ValueChanged<int>? onCommentDeleted;

  final ScrollController controller;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showReplyTextField = false;
  late bool _isLiked;
  late UserInformation userInformation;
  bool isDeleting = false;
  @override
  initState() {
    super.initState();
    _isLiked = widget.comment.isLiked ?? false;
    userInformation = widget.comment.user ?? dummyUserInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          leading: InkWell(
            onTap: () {
              if (userInformation.profileImage != null) {
                showDialog(
                  context: context,
                  builder: (_) => Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 220.h),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: formatImageUrl(
                            userInformation.profileImage ?? avatarImage),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error_outline_outlined),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              backgroundImage: CachedNetworkImageProvider(
                formatImageUrl(userInformation.profileImage ?? avatarImage),
              ),
              radius: 20.r,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userInformation.name!,
                style: Styles.semiBoldPoppins14,
              ),
              Text(getRelativeTime(widget.comment.createdAt!),
                  style: Styles.regularPoppins12.copyWith(
                    fontSize: 10,
                    color: AppColors.grey,
                  ))
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
                      style: Styles.regularPoppins12.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      widget.status == 'pending'
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                if (_isLiked) {
                                  context.read<CommentLikeCubit>().deleteLike(
                                      commentId: widget.comment.id!);
                                } else {
                                  context
                                      .read<CommentLikeCubit>()
                                      .addLike(commentId: widget.comment.id!);
                                }
                              },
                              child: BlocListener<CommentLikeCubit,
                                  CommentLikeState>(
                                listener: (context, state) {
                                  if (state is AddLikeSuccess) {
                                    _isLiked = true;
                                  }
                                  if (state is DeleteLikeSuccess) {
                                    _isLiked = false;
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
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      getUserData().userInfo?.id == userInformation.id
                          ? BlocListener<DeleteCommentCubit,
                              DeleteCommentState>(
                              listener: (context, state) {
                                if (state is DeleteCommentSuccess) {
                                  widget.onDeleteComment?.call(true);
                                  showCustomSnackBar(
                                      message: state.message,
                                      context: context,
                                      backgroundColor: const Color(0xFF0F8737));
                                  Navigator.pop(context);
                                }
                                if (state is DeleteCommentFailure) {
                                  showCustomSnackBar(
                                      message: state.errMesage,
                                      context: context);
                                  Navigator.pop(context);
                                }
                              },
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    useRootNavigator: false,
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      actionsAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      title: const Text(
                                        'Delete Comment',
                                        style: Styles.semiBoldPoppins20,
                                      ),
                                      content: const Text(
                                        'Are you sure you want to delete this comment?',
                                        style: Styles.regularPoppins14,
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 35.w,
                                                  vertical: 10.h),
                                              side: const BorderSide(
                                                  color: Color(0xFFD60000),
                                                  width: 1)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: Styles.regularPoppins14
                                                .copyWith(
                                                    color: const Color(
                                                        0xFFD60000)),
                                          ),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 35.w,
                                                vertical: 10.h),
                                            backgroundColor:
                                                const Color(0xFFD60000),
                                          ),
                                          onPressed: () {
                                            if (isDeleting) {
                                              return;
                                            }
                                            setState(() {
                                              isDeleting = true;
                                            });
                                            context
                                                .read<DeleteCommentCubit>()
                                                .deleteComment(
                                                    commentId:
                                                        widget.comment.id!);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: Styles.regularPoppins14
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: SvgPicture.asset(
                                  Assets.assetsImagesDelete,
                                  width: 14,
                                  colorFilter: const ColorFilter.mode(
                                    Color(0xffBB1313),
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              widget.status == 'pending'
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        setState(() {
                          showReplyTextField = !showReplyTextField;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Assets.assetsImagesReply),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('Reply',
                              style: Styles.regularPoppins12
                                  .copyWith(color: AppColors.grey)),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              widget.comment.replies?.isEmpty ?? true
                  ? const SizedBox.shrink()
                  : widget.status == 'pending'
                      ? const SizedBox.shrink()
                      : RepliesListViewWidget(
                          commentIndex: widget.commentIndex,
                          replies: widget.comment.replies,
                          controller: widget.controller,
                          onCommentDeleted: (value) {
                            widget.onCommentDeleted!(value);
                          },
                        ),
              showReplyTextField
                  ? Animate(
                      effects: const [
                        FadeEffect(
                          duration: Duration(milliseconds: 300),
                        ),
                        ScaleEffect(
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                      child: CommentTextField(
                          onSubmitted: (value) {
                            context.read<CommentsCubit>().addReply(
                                isPending: widget.status == 'pending',
                                mediaId: widget.comment.mediaId!,
                                parentId: widget.comment.id!);
                          },
                          autofocus: true,
                          controller:
                              context.read<CommentsCubit>().replyController,
                          onTap: () {
                            if (context
                                .read<CommentsCubit>()
                                .replyController
                                .text
                                .isEmpty) {
                              return;
                            }
                            context.read<CommentsCubit>().addReply(
                                isPending: widget.status == 'pending',
                                mediaId: widget.comment.mediaId!,
                                parentId: widget.comment.id!);
                          }),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
