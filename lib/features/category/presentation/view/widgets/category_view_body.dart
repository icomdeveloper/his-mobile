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
                height: 32,
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
                  height: 32.h,
                ),
                Text(
                  '$selectedMonth\'s Videos',
                  style: Styles.semiBoldRoboto20,
                ),
                const SizedBox(
                  height: 12,
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
