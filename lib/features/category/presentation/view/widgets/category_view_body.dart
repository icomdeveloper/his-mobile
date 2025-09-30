import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/category/data/model/categories/categories.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/cubits/media_by_category_cubit/media_by_category_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/category_list.dart';

import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_sliver_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CategoryViewBody extends StatefulWidget {
  const CategoryViewBody({super.key, required this.categories});
  final List<Categories> categories;
  @override
  State<CategoryViewBody> createState() => _CategoryViewBodyState();
}

class _CategoryViewBodyState extends State<CategoryViewBody> {
  late String selectedMonth;
  late String selectedYear;
  late int yearIndex;
  bool showComments = false;
  late int monthId;
  List<MediaModel> mediaList = [];
  List<MediaModel>? filteredMediaList;
  final TextEditingController _searchController = TextEditingController();
  @override
  initState() {
    super.initState();
    selectedYear = widget.categories.first.name.toString();
    selectedMonth =
        widget.categories.first.subcategories!.first.name.toString();
    yearIndex = 0;
    monthListIndex = 0;
    monthId = widget.categories[0].subcategories!.first.id ?? 0;
    _searchController.addListener(_filterItems);
    // context
    //     .read<MediaByCategoryCubit>()
    //     .getMediaByCategory(categoryId: monthId, context: context);
  }

  void _filterItems() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredMediaList = mediaList.where((item) {
        return item.title!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('category'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          context.read<MediaByCategoryCubit>().getMediaByCategory(
                categoryId: monthId,
                context: context,
              );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Search in Category',
                    controller: _searchController,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: 32,
                  width: double.infinity,
                  child: YearList(
                    onItemTapped: (value) {
                      if (selectedYear == widget.categories[value].name!) {
                        setState(() {
                          monthListIndex = 0;
                          selectedMonth = widget.categories[value]
                              .subcategories![monthListIndex].name!;
                          monthId =
                              widget.categories[value].subcategories![0].id ??
                                  0;
                        });
                      } else {
                        setState(() {
                          selectedYear = widget.categories[value].name!;
                          yearIndex = value;
                          monthId =
                              widget.categories[value].subcategories![0].id ??
                                  0;
                          monthListIndex = 0;
                          selectedMonth = widget.categories[value]
                              .subcategories![monthListIndex].name!;
                        });
                      }
                      log(selectedYear);
                      context.read<MediaByCategoryCubit>().getMediaByCategory(
                          categoryId: monthId, context: context);
                    },
                    categoryList:
                        widget.categories.map((e) => e.name!).toList(),
                  )),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                  height: 28.h,
                  width: double.infinity,
                  child: MonthList(
                    onItemTapped: (value) {
                      if (selectedMonth ==
                          widget.categories[yearIndex].subcategories![value]
                              .name) return;
                      setState(() {
                        selectedMonth = widget
                            .categories[yearIndex].subcategories![value].name!;
                        monthId = widget
                            .categories[yearIndex].subcategories![value].id!;
                        monthListIndex = value;
                      });
                      context.read<MediaByCategoryCubit>().getMediaByCategory(
                          categoryId: monthId, context: context);
                    },
                    categoryList: widget.categories[yearIndex].subcategories!
                        .map((e) => e.name!)
                        .toList(),
                  )),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    '$selectedMonth\'s Videos',
                    style: Styles.semiBoldPoppins20,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            BlocBuilder<MediaByCategoryCubit, MediaByCategoryState>(
              builder: (context, state) {
                if (state is MediaByCategorySuccess) {
                  if (state.mediaList.isEmpty) {
                    return SliverToBoxAdapter(
                        child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: CustomErrorWidget(
                        errorMessage: 'No videos found',
                        onTap: () {
                          context
                              .read<MediaByCategoryCubit>()
                              .getMediaByCategory(
                                  categoryId: monthId, context: context);
                        },
                      ),
                    ));
                  }
                  mediaList = state.mediaList;
                  return VideoCardSliverList(
                    mediaList: filteredMediaList ?? mediaList,
                  );
                } else if (state is MediaByCategoryFailure) {
                  return SliverToBoxAdapter(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: CustomErrorWidget(
                      errorMessage: state.errMessage,
                      onTap: () {
                        context.read<MediaByCategoryCubit>().getMediaByCategory(
                            categoryId: monthId, context: context);
                      },
                    ),
                  ));
                } else {
                  return Skeletonizer.sliver(
                      child: VideoCardSliverList(
                    mediaList: dummyMediaList,
                  ));
                }
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24.h),
            ),
          ],
        ),
      ),
    );
  }
}
