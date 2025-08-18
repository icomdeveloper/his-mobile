import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:his/core/helpers/notifications_count_provider.dart';
import 'package:his/core/repo/notifications_repo.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/widgets/build_offline_widget.dart';
import 'package:his/features/notifications/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:his/features/profile/data/repo/get_users_repo.dart';
import 'package:his/features/profile/presentation/cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/profile_view_body.dart';
import 'package:provider/provider.dart';

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
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              GetUserInfoCubit(getIt<GetUsersRepo>()),
                        ),
                        BlocProvider(
                          create: (context) =>
                              NotificationCubit(getIt<NotificationsRepo>())
                                ..getNotifications(context: context),
                        ),
                      ],
                      child: ChangeNotifierProvider(
                          create: (context) => NotificationsCountProvider(),
                          child: const ProfileViewBody()),
                    );
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
