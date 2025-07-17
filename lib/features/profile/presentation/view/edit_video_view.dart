import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';
import 'package:his/features/profile/presentation/cubits/edit_media_cubit/edit_media_cubit.dart';

class EditVideoView extends StatelessWidget {
  const EditVideoView({super.key, required this.mediaModel});
  final MediaModel mediaModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Post', style: Styles.semiBoldPoppins20),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.grey,
            size: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              final editMediaCubit = context.read<EditMediaCubit>();
              context.read<EditMediaCubit>().editMedia(
                  mediaId: mediaModel.id!,
                  userId: mediaModel.userId!,
                  year: '2025',
                  month: 'september');

              showDialog(
                context: context,
                barrierDismissible: false,
                useRootNavigator: false,
                builder: (_) {
                  return BlocProvider.value(
                    value: editMediaCubit,
                    child: BlocBuilder<EditMediaCubit, EditMediaState>(
                      builder: (context, state) {
                        if (state is EditMediaFailure) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  'Failed!!!',
                                  style: Styles.semiBoldPoppins20,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.errMessage,
                                  style: Styles.regularPoppins14,
                                ),
                              ],
                            ),
                            actions: [
                              CustomTextButton(
                                text: 'Back',
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                backgroundColor: Colors.white,
                                borderColor: AppColors.primaryColor,
                                textColor: AppColors.primaryColor,
                                isArrowAppear: false,
                              ),
                            ],
                          );
                        } else if (state is EditMediaSuccess) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Column(
                              children: [
                                SvgPicture.asset(Assets.assetsImagesSuccess),
                                const SizedBox(height: 10),
                                const Text(
                                  'Success !',
                                  style: Styles.semiBoldPoppins20,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Post saved successfully.',
                                  style: Styles.regularPoppins14,
                                ),
                              ],
                            ),
                            actions: [
                              CustomTextButton(
                                text: 'Back',
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                backgroundColor: Colors.white,
                                borderColor: AppColors.primaryColor,
                                textColor: AppColors.primaryColor,
                                isArrowAppear: false,
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
            child: const Text(
              'Save',
              style: Styles.semiBoldPoppins14,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: VideoWidget(
          likesCount: mediaModel.likesCount ?? 0,
          mediaModel: mediaModel,
          isEdit: true,
        ),
      ),
    );
  }
}
