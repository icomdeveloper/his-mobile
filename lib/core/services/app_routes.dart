import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/repo/notifications_repo.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
import 'package:his/features/notifications/presentation/cubit/notification_cubit/notification_cubit.dart';
import 'package:his/features/notifications/presentation/view/notification_view.dart';
import 'package:his/features/on_boarding/presentation/view/on_boarding_view.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (_) => const MainView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case NotificationView.routeName:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (context) =>
                    NotificationCubit(getIt<NotificationsRepo>())
                      ..getNotifications(),
                child: const NotificationView(),
              ));

    default:
      return null;
  }
}
