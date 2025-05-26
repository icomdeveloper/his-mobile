import 'package:flutter/material.dart';
import 'package:his/core/helpers/indexed_stack_provider.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/main_screen/data/model/nav_bar_model.dart';
import 'package:his/features/main_screen/presentation/view/widgets/custom_bottom_nav_bar_items.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key, required this.onItemTapped});
  final ValueChanged<int> onItemTapped;
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<NavBarModel> navigationBarList = [
    const NavBarModel(
      title: 'Home',
      image: Assets.assetsImagesHome,
    ),
    const NavBarModel(
      title: 'Category',
      image: Assets.assetsImagesCategories,
    ),
    const NavBarModel(
      title: 'Bookmarks',
      image: Assets.assetsImagesBookmarked,
    ),
    const NavBarModel(
      title: 'Profile',
      image: Assets.assetsImagesProfile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var selectedIndex = Provider.of<IndexStackProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Container(
      height: isPortrait
          ? mediaQuery.size.height * 0.1
          : mediaQuery.size.height * 0.2,
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
              children: navigationBarList.asMap().entries.map((entry) {
            int index = entry.key;
            var model = entry.value;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  selectedIndex.setIndex(index);
                  widget.onItemTapped(index);
                  setState(() {});
                },
                child: CustomBottomNavBarItems(
                  isActive: index == selectedIndex.currentIndex,
                  navBarModel: model,
                ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
