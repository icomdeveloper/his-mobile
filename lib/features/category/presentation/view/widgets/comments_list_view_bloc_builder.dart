import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/category/presentation/cubits/get_comments_cubit/get_comments_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/comments_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentListViewBlocBuilder extends StatelessWidget {
  const CommentListViewBlocBuilder({
    super.key,
    required this.mediaId,
    required this.status,
  });
  final int mediaId;
  final String status;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCommentsCubit, GetCommentsState>(
      builder: (context, state) {
        if (state is GetCommentsSuccess) {
          return SizedBox(
            height: state.comments.isEmpty
                ? commentsList.isEmpty
                    ? 80.h
                    : 300.h
                : 300.h,
            child: CommentsListView(
              status: status,
              comments: state.comments,
            ),
          );
        } else if (state is GetCommentsFailure) {
          return SizedBox(
            height: 80.h,
            child: Center(
              child: CustomErrorWidget(
                errorMessage: state.message,
                onTap: () {
                  context.read<GetCommentsCubit>().getComments(
                      mediaId: mediaId, isPending: status == 'pending');
                },
              ),
            ),
          );
        } else {
          return Skeletonizer(
              child: SizedBox(
            height: 350.h,
            child: CommentsListView(
              status: status,
              isDummy: true,
              comments: dummyCommentList,
            ),
          ));
        }
      },
    );
  }
}
