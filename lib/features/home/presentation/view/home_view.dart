import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
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
                      return const HomeViewBody();
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
