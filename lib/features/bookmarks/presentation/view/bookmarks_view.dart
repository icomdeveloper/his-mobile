import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
import 'package:his/features/bookmarks/data/repos/bookmarks_repo.dart';
import 'package:his/features/bookmarks/presentation/cubits/bookmarks_cubit/bookmarks_cubit.dart';
import 'package:his/features/bookmarks/presentation/cubits/get_bookmarks_cubit/get_bookmarks_cubit.dart';
import 'package:his/features/bookmarks/presentation/view/widgets/bookmarks_view_body.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({super.key, required this.navigatorKey});
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
              appBar: buildAppBar(context,
                  title: 'My Bookmarks',
                  centerTitle: false,
                  showBackButton: false),
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
                        BlocProvider(
                          create: (context) =>
                              GetBookmarksCubit(getIt<BookmarksRepo>()),
                        ),
                        BlocProvider(
                          create: (context) =>
                              BookmarksCubit(getIt<BookmarksRepo>()),
                        ),
                      ],
                      child: const BookmarksViewBody(),
                    );
                  } else {
                    return buildOfflineWidget();
                  }
                },
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
