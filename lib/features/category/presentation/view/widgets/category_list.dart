import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class YearList extends StatefulWidget {
  const YearList(
      {super.key, required this.categoryList, required this.onItemTapped});
  final List<String> categoryList;
  final ValueChanged<int> onItemTapped;
  @override
  State<YearList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<YearList> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      scrollDirection: Axis.horizontal,
      itemCount: widget.categoryList.length,
      itemBuilder: (context, index) {
        return InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onTap: () {
            widget.onItemTapped(index);
            setState(() {
              selectedIndex = index;
            });
          },
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
                  horizontal: index == selectedIndex ? 16 : 12, vertical: 8),
              child: Text(
                widget.categoryList[index],
                textAlign: TextAlign.center,
                style: Styles.regularPoppins12.copyWith(
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

int monthListIndex = 0;

class MonthList extends StatefulWidget {
  const MonthList(
      {super.key, required this.categoryList, required this.onItemTapped});
  final List<String> categoryList;
  final ValueChanged<int> onItemTapped;
  @override
  State<MonthList> createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      scrollDirection: Axis.horizontal,
      itemCount: widget.categoryList.length,
      itemBuilder: (context, index) {
        return InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onTap: () {
            widget.onItemTapped(index);
            setState(() {
              monthListIndex = index;
            });
          },
          child: Column(
            children: [
              Center(
                child: Text(widget.categoryList[index],
                    style: Styles.regularPoppins14.copyWith(
                      color: index == monthListIndex
                          ? AppColors.primaryColor
                          : AppColors.grey,
                    )),
              ),
              const SizedBox(height: 4),
              index == monthListIndex
                  ? Container(
                      height: 1, width: 45.w, color: AppColors.primaryColor)
                  : const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
