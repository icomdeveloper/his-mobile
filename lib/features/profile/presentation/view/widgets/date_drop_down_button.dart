import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:his/constants.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class DateDropDownButton extends StatefulWidget {
  const DateDropDownButton({super.key, this.isMonth = false});
  final bool isMonth;
  @override
  State<DateDropDownButton> createState() => _DateDropDownButtonState();
}

class _DateDropDownButtonState extends State<DateDropDownButton> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      isExpanded: true,
      decoration: InputDecoration(
        border: buildBorder(),
        enabledBorder: buildBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      ),
      hint: Row(
        children: [
          Expanded(
            child: Text(
              widget.isMonth ? 'Select month' : 'Select year',
              style: Styles.regularRoboto12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: widget.isMonth
          ? monthList
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: Styles.semiBoldRoboto12,
                    ),
                  ))
              .toList()
          : yearList
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: Styles.semiBoldRoboto12),
                  ))
              .toList(),
      validator: (value) {
        if (value == null) {
          return widget.isMonth ? 'Please select month' : 'Please select year';
        }
        return null;
      },
      onChanged: (value) {
        //Do something when selected item is changed.
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
        ),
        iconSize: 16,
        iconEnabledColor: AppColors.grey,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(14)),
    );
  }
}
