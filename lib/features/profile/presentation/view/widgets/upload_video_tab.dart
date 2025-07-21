import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/category/presentation/cubits/categories_cubit/categories_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/upload_video_tab_body.dart';

class UploadVideoTab extends StatelessWidget {
  const UploadVideoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          return UploadVideoTabBody(
            categories: state.categories,
          );
        } else if (state is CategoriesFailure) {
          return Center(
              child: CustomErrorWidget(
            errorMessage: state.message,
            onTap: () => context.read<CategoriesCubit>().getCategories(),
          ));
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        }
      },
    );
  }
}
