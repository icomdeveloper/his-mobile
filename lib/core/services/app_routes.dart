import 'package:flutter/material.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
import 'package:his/features/on_boarding/presentation/view/on_boarding_view.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (_) => const MainView());

    default:
      return null;
  }
}
