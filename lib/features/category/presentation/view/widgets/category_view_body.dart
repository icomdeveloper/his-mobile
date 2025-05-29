import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/presentation/view/widgets/category_list.dart';

import 'package:his/features/home/presentation/view/widgets/custom_text_field.dart';
import 'package:his/features/home/presentation/view/widgets/recommended_videos_list.dart';

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

          const RecommendedVideosList(),
          // SliverToBoxAdapter(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(
          //         height: 24.h,
          //       ),
          //       const Text(
          //         'Recently Added',
          //         style: Styles.semiBoldRoboto20,
          //       ),
          //       const SizedBox(
          //         height: 12,
          //       ),
          //     ],
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 250,
          //     child: ListView.separated(
          //       separatorBuilder: (context, index) => const SizedBox(width: 12),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: 10,
          //       itemBuilder: (context, index) {
          //         return const CategoryRecentlyAddedItem();
          //       },
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
          // SliverToBoxAdapter(
          //   child: VideoWidget(
          //     onTap: () {
          //       setState(() {
          //         showComments = !showComments;
          //         if (showComments) {
          //           _scrollToBottom();
          //         }
          //       });
          //     },
          //     showComments: showComments,
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: SizedBox(height: 24.h),
          // ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
