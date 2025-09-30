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
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/category/data/repo/comments_repo.dart';
import 'package:his/features/category/presentation/cubits/comments_cubit/comments_cubit.dart';
import 'package:his/features/category/presentation/cubits/delete_comment_cubit/delete_comment_cubit.dart';
import 'package:his/features/category/presentation/cubits/get_comments_cubit/get_comments_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comment_text_field.dart';
import 'package:his/features/category/presentation/view/widgets/second_reply_widget.dart';
import 'package:his/features/home/data/models/comments_model/reply_model.dart';
import 'package:his/features/home/data/repo/media_likes_repo.dart';
import 'package:his/features/home/presentation/cubits/comment_likes_cubit/comment_like_cubit.dart';

import '../../../../../core/utils/app_colors.dart';

class ReplyWidget extends StatefulWidget {
  const ReplyWidget({
    super.key,
    required this.reply,
    required this.index,
    this.isSecondReply = false,
    this.onDeleteReply,
  });

  final ReplyModel reply;
  final int index;
  final bool isSecondReply;
  final ValueChanged<bool>? onDeleteReply;

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  bool showReplyTextField = false;
  late bool _isLiked;
  late UserInformation userInformation;
  bool isDeleting = false;
  bool showMoreReplies = false;
  @override
  initState() {
    super.initState();
    _isLiked = widget.reply.isLiked ?? false;
    userInformation = widget.reply.user ?? dummyUserInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          minTileHeight: 62.h,
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          leading: InkWell(
            onTap: () {
              if (widget.reply.user?.profileImage != null) {
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
                        imageUrl:
                            widget.reply.user?.profileImage ?? avatarImage,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
            },
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  widget.reply.user?.profileImage ?? avatarImage),
              radius: 12.r,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.reply.user?.name ?? '',
                style: Styles.semiBoldPoppins12,
              ),
              Text(getRelativeTime(widget.reply.createdAt ?? DateTime.now()),
                  style: Styles.regularPoppins12.copyWith(
                    fontSize: 10,
                    color: AppColors.grey,
                  )),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5),
                    child: Text(widget.reply.content ?? '',
                        style: Styles.regularPoppins12.copyWith(
                          color: AppColors.grey,
                        )),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (_isLiked) {
                            context
                                .read<CommentLikeCubit>()
                                .deleteLike(commentId: widget.reply.id!);
                          } else {
                            context
                                .read<CommentLikeCubit>()
                                .addLike(commentId: widget.reply.id!);
                          }
                        },
                        child: BlocListener<CommentLikeCubit, CommentLikeState>(
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
                                if (state is DeleteReplySuccess) {
                                  widget.onDeleteReply?.call(true);
                                  context.read<GetCommentsCubit>().getComments(
                                      mediaId: widget.reply.mediaId!,
                                      isPending: false);
                                  showCustomSnackBar(
                                      message: state.message,
                                      context: context,
                                      backgroundColor: const Color(0xFF0F8737));
                                  Navigator.pop(context);
                                }
                                if (state is DeleteReplyFailure) {
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
                                                .deleteReply(
                                                    replyId: widget.reply.id!);
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
                  ),
                ],
              ),
              if (widget.reply.secondReplies != null &&
                  widget.reply.secondReplies!.isNotEmpty)
                SizedBox(
                  height: 12.h,
                ),
              widget.isSecondReply
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
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.reply.secondReplies == null ||
                          widget.reply.secondReplies!.isEmpty
                      ? 0
                      : showMoreReplies
                          ? widget.reply.secondReplies!.length
                          : 1,
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
                      child: SecondReplyWidget(
                        reply: widget.reply.secondReplies![index],
                        index: index,
                        isSecondReply: true,
                      ),
                    );
                  }),
              if (widget.reply.secondReplies != null &&
                  widget.reply.secondReplies!.length > 1)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showMoreReplies = !showMoreReplies;
                    });
                  },
                  child: Text(
                    showMoreReplies
                        ? 'Hide ${widget.reply.secondReplies!.length - 1} reply'
                        : 'Show ${widget.reply.secondReplies!.length - 1} reply',
                    style: Styles.semiBoldPoppins12.copyWith(
                      fontSize: 11,
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              showReplyTextField
                  ? SizedBox(
                      height: 10.h,
                    )
                  : const SizedBox.shrink(),
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
                            if (value.isEmpty) {
                              return;
                            }
                            context.read<CommentsCubit>().addSecondReply(
                                isPending: true,
                                mediaId: widget.reply.mediaId!,
                                parentId: widget.reply.id!);
                          },
                          autofocus: true,
                          controller: context
                              .read<CommentsCubit>()
                              .secondReplyController,
                          onTap: () {
                            if (context
                                .read<CommentsCubit>()
                                .secondReplyController
                                .text
                                .isEmpty) {
                              return;
                            }
                            context.read<CommentsCubit>().addSecondReply(
                                isPending: false,
                                mediaId: widget.reply.mediaId!,
                                parentId: widget.reply.id!);
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
