import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
