import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
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
            return Scaffold(
              backgroundColor: Colors.white,
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  List<ConnectivityResult> connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      !connectivity.contains(ConnectivityResult.none);
                  if (connected) {
                    return const ProfileViewBody();
                  } else {
                    return buildOfflineWidget();
                  }
                },
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
