import 'package:flutter/material.dart';
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
              return const Scaffold(body: SafeArea(child: HomeViewBody()));
            },
          );
        });
  }
}
