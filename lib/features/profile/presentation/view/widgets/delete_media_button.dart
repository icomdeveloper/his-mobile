import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';

import '../../cubits/delete_media_cubit/delete_media_cubit.dart';

class DeleteMediaButton extends StatelessWidget {
  const DeleteMediaButton({
    super.key,
    required this.mediaId,
  });
  final int mediaId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteMediaCubit, DeleteMediaState>(
      listener: (context, state) {
        if (state is DeleteMediaSuccess) {
          showCustomSnackBar(
              message: state.message,
              context: context,
              backgroundColor: const Color(0xFF0F8737));
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is DeleteMediaFailure) {
          showCustomSnackBar(
            message: state.errMessage,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return state is DeleteMediaLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomTextButton(
                text: 'Delete Post',
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: Colors.white,
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      title: const Text(
                        'Are you sure you want to delete this post ?',
                        style: Styles.semiBoldPoppins20,
                      ),
                      content: const Text(
                        'This will permanently remove the post and cannot be undone.',
                        style: Styles.regularPoppins14,
                      ),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35.w, vertical: 10.h),
                              side: const BorderSide(
                                  color: Color(0xFFD60000), width: 1)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: Styles.regularPoppins14
                                .copyWith(color: const Color(0xFFD60000)),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35.w, vertical: 10.h),
                              backgroundColor: const Color(0xFFD60000)),
                          onPressed: () {
                            context.read<DeleteMediaCubit>().deleteMedia(
                                  mediaId: mediaId,
                                );
                            Navigator.pop(context);
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
                isArrowAppear: false,
              );
      },
    );
  }
}
