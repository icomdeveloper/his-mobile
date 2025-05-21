import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:his/core/helpers/indexed_stack_provider.dart';
import 'package:his/features/category/presentation/view/category_view.dart';
import 'package:his/features/home/presentation/view/home_view.dart';
import 'package:his/features/main_screen/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  Map<int, GlobalKey> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    final indexStack = Provider.of<IndexStackProvider>(context);

    List<Widget> screens = [
      HomeView(navigatorKey: navigatorKeys[0]!),
      const CategoryView(),
      const Center(
        child: Text('Bookmarks'),
      ),
      const Center(
        child: Text('Profile'),
      ),
    ];
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        onItemTapped: (value) {
          indexStack.setIndex(value);
          setState(() {});
        },
      ),
      body: SafeArea(
          child: PopScope(
        canPop: false, // Prevents default back button behavior
        onPopInvokedWithResult: (bool didPop, _) async {
          if (didPop) return Future.value(true);

          log('On Pop invoked ${navigatorKeys[indexStack.currentIndex]!.currentState!.context.widget}');
          final canPop = await Navigator.maybePop(
              navigatorKeys[indexStack.currentIndex]!.currentState!.context);

          return Future.value(
              !canPop); // Return true to prevent pop, false to allow
        },
        child: IndexedStack(index: indexStack.currentIndex, children: screens),
      )),
    );
  }

  // Widget _buildTabNavigator(Widget child) {
  //   return Navigator(
  //     onGenerateRoute: (RouteSettings settings) {
  //       return MaterialPageRoute(
  //         builder: (_) => child,
  //         settings: settings,
  //       );
  //     },
  //   );
  // }
}
