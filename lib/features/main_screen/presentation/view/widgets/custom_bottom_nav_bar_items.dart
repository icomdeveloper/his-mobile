import 'package:flutter/material.dart';
import 'package:his/features/main_screen/data/model/nav_bar_model.dart';
import 'package:his/features/main_screen/presentation/view/widgets/active_item.dart';
import 'package:his/features/main_screen/presentation/view/widgets/in_active_item.dart';

class CustomBottomNavBarItems extends StatelessWidget {
  const CustomBottomNavBarItems(
      {super.key, required this.isActive, required this.navBarModel});
  final bool isActive;
  final NavBarModel navBarModel;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveItem(
            navBarModel: navBarModel,
          )
        : InActiveItem(
            navBarModel: navBarModel,
          );
  }
}
