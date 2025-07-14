import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
import 'package:his/features/category/data/repo/media_by_category_repo.dart';
import 'package:his/features/category/presentation/cubits/categories_cubit/categories_cubit.dart';
import 'package:his/features/category/presentation/cubits/media_by_category_cubit/media_by_category_cubit.dart';
import 'package:his/features/category/presentation/view/widgets/category_view_body.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.navigatorKey});
  final GlobalKey navigatorKey;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(context,
                title: 'Categories', showBackButton: false, centerTitle: false),
            body: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                List<ConnectivityResult> connectivity,
                Widget child,
              ) {
                final bool connected =
                    !connectivity.contains(ConnectivityResult.none);
                if (connected) {
                  return MultiBlocProvider(
                    providers: [
                      // BlocProvider(
                      //   create: (context) =>
                      //       GetMediaCubit(getIt<ShowMediaRepo>()),
                      // ),
                      BlocProvider(
                        create: (context) =>
                            MediaByCategoryCubit(getIt<MediaByCategoryRepo>()),
                      ),
                    ],
                    child: BlocBuilder<CategoriesCubit, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesSuccess) {
                          return CategoryViewBody(categories: state.categories);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  );
                } else {
                  return buildOfflineWidget();
                }
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
