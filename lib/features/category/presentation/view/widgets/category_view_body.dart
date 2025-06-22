import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:his/features/category/presentation/view/widgets/category_list.dart';
import 'package:his/features/category/presentation/cubits/get_media_cubit/get_media_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/video_card_list_bloc_builder.dart';

import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';

class CategoryViewBody extends StatefulWidget {
  const CategoryViewBody({super.key});

  @override
  State<CategoryViewBody> createState() => _CategoryViewBodyState();
}

class _CategoryViewBodyState extends State<CategoryViewBody> {
  List<String> categoryList = const [
    '2025',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
  ];
  String selectedCategory = '2025';
  bool showComments = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Search in Category',
                ),
                SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: 32,
                width: double.infinity,
                child: CategoriesList(
                  onItemTapped: (value) {
                    if (value == categoryList.indexOf(selectedCategory)) return;
                    setState(() {
                      selectedCategory = categoryList[value];
                    });
                  },
                  categoryList: categoryList,
                )),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  '$selectedCategory\'s Videos',
                  style: Styles.semiBoldRoboto20,
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) =>
                GetMediaCubit(getIt<ShowMediaRepo>())..getVideos(),
            child: const VideoCardListBlocBuilder(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
        ],
      ),
    );
  }
}
