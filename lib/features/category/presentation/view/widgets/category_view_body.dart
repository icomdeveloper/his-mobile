import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/category/presentation/view/widgets/category_list.dart';
import 'package:his/features/category/presentation/view/widgets/category_recently_added_item.dart';
import 'package:his/features/category/presentation/view/widgets/video_widget.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_field.dart';

class CategoryViewBody extends StatelessWidget {
  const CategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
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
                height: 32.h,
                width: double.infinity,
                child: CategoriesList(
                  onItemTapped: (value) {},
                  categoryList: const [
                    '2025',
                    '2024',
                    '2023',
                    '2022',
                    '2021',
                    '2020',
                  ],
                )),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                const Text(
                  'Recently Added',
                  style: Styles.semiBoldRoboto20,
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250.h,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CategoryRecentlyAddedItem();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
          const SliverToBoxAdapter(
            child: VideoWidget(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24.h),
          ),
        ],
      ),
    );
  }
}
