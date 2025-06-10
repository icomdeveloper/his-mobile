import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
import 'package:his/features/category/presentation/view/widgets/category_view_body.dart';
import 'package:his/features/category/data/repo/show_media_repo.dart';
import 'package:his/features/category/presentation/cubit/get_media_cubit.dart';

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
                  return BlocProvider(
                    create: (context) =>
                        GetMediaCubit(getIt<ShowMediaRepo>())..getMedia(),
                    child: const CategoryViewBody(),
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
