import 'package:flutter/material.dart';
import 'package:his/core/utils/app_text_styles.dart';
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
              appBar: AppBar(
                title: const Text(
                  'Categories',
                  style: Styles.semiBoldRoboto20,
                ),
              ),
              body: const CategoryViewBody()),
        );
      },
    );
  }
}
