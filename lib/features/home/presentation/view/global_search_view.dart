import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/home/presentation/cubits/global_search_cubit/global_search_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/home/presentation/view/widgets/video_card_sliver_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GlobalSearchView extends StatefulWidget {
  const GlobalSearchView({super.key});

  @override
  State<GlobalSearchView> createState() => _GlobalSearchViewState();
}

class _GlobalSearchViewState extends State<GlobalSearchView> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: VisibilityDetector(
        key: const Key('global_search_view'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1.0) {
            context.read<GlobalSearchCubit>().search(query: query);
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
                    SizedBox(
                      height: 12.h,
                    ),
                    CustomTextField(
                      hintText: 'Search ...',
                      isSearch: true,
                      onChanged: (value) {
                        query = value;
                        context.read<GlobalSearchCubit>().search(query: value);
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
              BlocBuilder<GlobalSearchCubit, GlobalSearchState>(
                builder: (context, state) {
                  if (state is GlobalSearchMediaSuccess) {
                    return VideoCardSliverList(
                      mediaList: state.mediaList,
                    );
                  } else if (state is GlobalSearchFailure) {
                    return SliverToBoxAdapter(
                        child: SizedBox(
                      height: 200.h,
                      child: Center(
                        child: Text(state.message,
                            style: Styles.semiBoldPoppins12
                                .copyWith(color: AppColors.darkGrey)),
                      ),
                    ));
                    // } else if (state is GlobalSearchArticleSuccess) {
                    //   return ArticlesSliverList(
                    //     articleList: state.articleList,
                    //   );
                  }
                  return SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80.h,
                        ),
                        SizedBox(
                          width: 200.w,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.asset(
                              Assets.assetsImagesVideoPlayer6760360,
                              fit: BoxFit.contain,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text('Search in what you are looking for here',
                            style: Styles.semiBoldPoppins12
                                .copyWith(color: AppColors.grey))
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
