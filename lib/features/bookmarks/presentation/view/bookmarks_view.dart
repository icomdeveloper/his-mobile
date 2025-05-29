import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
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
              appBar: buildAppBar(title: 'My Bookmarks'),
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  List<ConnectivityResult> connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      !connectivity.contains(ConnectivityResult.none);
                  if (connected) {
                    return const BookmarksViewBody();
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
