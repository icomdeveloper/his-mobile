import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList(
      {super.key, required this.categoryList, required this.onItemTapped});
  final List<String> categoryList;
  final ValueChanged<int> onItemTapped;
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.categoryList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              side: BorderSide(
                color: index == selectedIndex
                    ? Colors.transparent
                    : const Color(0xffEDEDED),
                width: 1,
              ),
              backgroundColor: index == selectedIndex
                  ? AppColors.primaryColor
                  : Colors.transparent,
            ),
            onPressed: () {
              setState(() {
                if (selectedIndex == index) {
                  return;
                } else {
                  selectedIndex = index;
                }
                widget.onItemTapped(index);
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: index == selectedIndex ? 18 : 12),
              child: Text(
                widget.categoryList[index],
                style: Styles.regularRoboto12.copyWith(
                  color: index == selectedIndex ? Colors.white : AppColors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
