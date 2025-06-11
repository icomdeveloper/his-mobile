import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
  });
  @override
  State<CustomDropDownButton> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDownButton> {
  final List<DropDownItemWidget> items = List.generate(
      authors.length,
      (index) => DropDownItemWidget(
            image: authors[index]['image'],
            name: authors[index]['name'],
          ));
  DropDownItemWidget? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<DropDownItemWidget>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
          ),
        ),
        validator: (value) => value == null ? 'please select an author' : null,
        selectedItemBuilder: (context) => items
            .map((item) => Row(
                  children: [
                    Text(item.name, style: Styles.regularRoboto12),
                  ],
                ))
            .toList(),
        iconStyleData: const IconStyleData(
          iconEnabledColor: AppColors.primaryColor,
        ),
        isExpanded: true,
        hint: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Search for author',
            style: Styles.regularRoboto12,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: item,
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
                BorderSide(color: AppColors.lightGrey, width: 1)),
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: 50,
          width: double.infinity,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                hintText: 'Search for author...',
                hintStyle: Styles.regularRoboto12
                    .copyWith(color: const Color(0xff999999)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.name.toString().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

class DropDownItemWidget extends StatelessWidget {
  const DropDownItemWidget(
      {super.key, required this.image, required this.name});
  final String image, name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(image),
          radius: 20,
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: Styles.regularRoboto12,
        ),
      ],
    );
  }
}

const List<Map<String, dynamic>> authors = [
  {
    'name': 'Mustafa Kamel',
    'image': 'https://i.pravatar.cc/300?img=1',
  },
  {
    'name': 'Ali Osama',
    'image': 'https://i.pravatar.cc/300?img=2',
  },
  {
    'name': 'Ibrahim Mohamed',
    'image': 'https://i.pravatar.cc/300?img=3',
  },
  {
    'name': 'Karim Salah',
    'image': 'https://i.pravatar.cc/300?img=4',
  },
];
