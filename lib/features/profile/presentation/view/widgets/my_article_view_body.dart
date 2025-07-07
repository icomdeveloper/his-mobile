import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/profile/data/repo/upload_article_repo.dart';
import 'package:his/features/profile/presentation/cubits/upload_article_cubit/upload_article_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/my_articles_tab_bar.dart';
import 'package:his/features/profile/presentation/view/widgets/upload_article_tab.dart';

class MyArticleViewBody extends StatefulWidget {
  const MyArticleViewBody({super.key});

  @override
  State<MyArticleViewBody> createState() => _MyArticleViewBodyState();
}

class _MyArticleViewBodyState extends State<MyArticleViewBody>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: 'Upload',
              ),
              Tab(
                text: 'Published',
              ),
            ],
            labelColor: const Color(0xff0F0F0F),
            physics: const NeverScrollableScrollPhysics(),
            indicatorColor: const Color(0xff0F0F0F),
            unselectedLabelColor: AppColors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: Styles.semiBoldPoppins14,
            unselectedLabelStyle: Styles.semiBoldPoppins14,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            dividerColor: AppColors.lightGrey,
            dividerHeight: 1,
            indicatorWeight: 2,
          ),
          Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                BlocProvider(
                  create: (context) =>
                      UploadArticleCubit(getIt<UploadArticleRepo>()),
                  child: UploadArticleTab(),
                ),
                MyArticlesTabBar(),
              ]))
        ],
      ),
    );
  }
}
