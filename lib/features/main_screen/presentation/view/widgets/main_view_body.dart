import 'package:flutter/material.dart';
import 'package:his/core/helpers/indexed_stack_provider.dart';
import 'package:his/features/home/presentation/view/home_view.dart';
import 'package:his/features/main_screen/presentation/view/widgets/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  @override
  Widget build(BuildContext context) {
    final indexStack = Provider.of<IndexStackProvider>(context);

    List<Widget> screens = [
      _buildTabNavigator(const HomeView()),
      const Center(
        child: Text('Category'),
      ),
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
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: IndexedStack(index: indexStack.currentIndex, children: screens),
      )),
    );
  }

  Widget _buildTabNavigator(Widget child) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (_) => child,
          settings: settings,
        );
      },
    );
  }
}
