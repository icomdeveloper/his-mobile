import 'package:flutter/material.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/category/presentation/view/widgets/category_view_body.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.navigatorKey});
  final GlobalKey navigatorKey;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Scaffold(
              appBar: buildAppBar(title: 'Categories'),
              body: const CategoryViewBody()),
        );
      },
    );
  }
}
