import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class YearDropDownButton extends StatefulWidget {
  const YearDropDownButton({
    super.key,
    this.valueSelected,
    this.yearList,
  });
  final ValueChanged<String?>? valueSelected;
  final List<String>? yearList;

  @override
  State<YearDropDownButton> createState() => _YearDropDownButtonState();
}

class _YearDropDownButtonState extends State<YearDropDownButton> {
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
              'Select year',
              style: Styles.regularPoppins12.copyWith(color: AppColors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: widget.yearList!
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: Styles.semiBoldPoppins12),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select year';
        }
        return null;
      },
      onChanged: (value) {
        selectedValue = value.toString();
        widget.valueSelected!(selectedValue);
      },
      onSaved: (value) {
        // selectedValue = value.toString();
        // widget.valueSelected!(selectedValue);
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
