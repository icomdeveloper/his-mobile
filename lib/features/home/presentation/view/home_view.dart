import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
import 'package:his/features/home/data/repo/recently_added_repo.dart';
import 'package:his/features/home/presentation/cubit/recently_added_cubit.dart';
import 'package:his/features/home/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.navigatorKey});
  final GlobalKey navigatorKey;
  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: OfflineBuilder(
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
                                RecentlyAddedCubit(getIt<RecentlyAddedRepo>())
                                  ..getRecentlyAddedVideos(),
                            child: const HomeViewBody(),
                          );
                        } else {
                          return buildOfflineWidget();
                        }
                      },
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ));
            },
          );
        });
  }
}
