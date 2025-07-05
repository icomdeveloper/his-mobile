import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/dummy_media.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/cubits/get_media_cubit/get_media_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/category_list.dart';

import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_sliver_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryViewBody extends StatefulWidget {
  const CategoryViewBody({super.key});

  @override
  State<CategoryViewBody> createState() => _CategoryViewBodyState();
}

class _CategoryViewBodyState extends State<CategoryViewBody> {
  List<String> yearList = const [
    '2025',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
  ];
  List<String> monthList = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String selectedYear = '2025';
  String selectedMonth = 'january';
  bool showComments = false;
  List<MediaModel> mediaList = [];
  List<MediaModel>? filteredMediaList;
  final TextEditingController _searchController = TextEditingController();
  @override
  initState() {
    super.initState();
    _searchController.addListener(_filterItems);
    context.read<GetMediaCubit>().getVideos();
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
    return Padding(
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
                    if (value == yearList.indexOf(selectedYear)) return;
                    setState(() {
                      selectedYear = yearList[value];
                    });
                  },
                  categoryList: yearList,
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
                    if (value == monthList.indexOf(selectedMonth)) return;
                    setState(() {
                      selectedMonth = monthList[value];
                    });
                  },
                  categoryList: monthList,
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
          BlocBuilder<GetMediaCubit, GetMediaState>(
            builder: (context, state) {
              if (state is GetMediaSuccess) {
                if (state.mediaList.isEmpty) {
                  return SliverToBoxAdapter(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: CustomErrorWidget(
                      errorMessage: 'No videos found',
                      onTap: () {
                        context.read<GetMediaCubit>().getVideos();
                      },
                    ),
                  ));
                }
                mediaList = state.mediaList;
                return VideoCardSliverList(
                  mediaList: filteredMediaList ?? mediaList,
                );
              } else if (state is GetMediaFailure) {
                return SliverToBoxAdapter(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: CustomErrorWidget(
                    errorMessage: state.message,
                    onTap: () {
                      context.read<GetMediaCubit>().getVideos();
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
    );
  }
}
