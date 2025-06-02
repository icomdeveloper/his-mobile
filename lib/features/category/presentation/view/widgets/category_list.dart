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
        return GestureDetector(
          onTap: () {
            widget.onItemTapped(index);
            setState(() {
              selectedIndex = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              decoration: ShapeDecoration(
                color: selectedIndex == index
                    ? AppColors.primaryColor
                    : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                    side: BorderSide(
                      width: 1,
                      color: selectedIndex == index
                          ? Colors.transparent
                          : AppColors.lightGrey,
                    )),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: index == selectedIndex ? 24 : 16, vertical: 8),
                child: Text(
                  widget.categoryList[index],
                  textAlign: TextAlign.center,
                  style: Styles.regularRoboto12.copyWith(
                    color:
                        index == selectedIndex ? Colors.white : AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
