import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
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
                appBar: buildAppBar(title: 'My Bookmarks'),
                body: const BookmarksViewBody());
          },
        );
      },
    );
  }
}
