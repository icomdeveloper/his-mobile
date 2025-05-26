import 'package:flutter/material.dart';
import 'package:his/features/profile/presentation/view/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.navigatorKey});
  final GlobalKey navigatorKey;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const Scaffold(body: ProfileViewBody());
          },
        );
      },
    );
  }
}
