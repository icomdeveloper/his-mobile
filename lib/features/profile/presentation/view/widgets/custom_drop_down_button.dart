import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:his/constants.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';
import 'package:his/features/profile/data/model/author_model.dart';
import 'package:his/features/profile/presentation/view/widgets/drop_down_item.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
    this.authorsList,
    required this.authors,
  });
  @override
  final ValueChanged<List<String>>? authorsList;
  final List<UserInformation> authors;
  @override
  State<CustomDropDownButton> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDownButton> {
  List<DropDownItemWidget> selectedItems = [];
  final TextEditingController textEditingController = TextEditingController();
  List<DropDownItemWidget> items = [];
  @override
  void initState() {
    items = List.generate(
        widget.authors.length,
        (index) => DropDownItemWidget(
              image: widget.authors[index].profileImage ?? avatarImage,
              name: widget.authors[index].name!,
            ));
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<DropDownItemWidget>(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: buildBorder(),
          enabledBorder: buildBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        ),
        // validator: (value) => value == null ? 'please select an author' : null,
        selectedItemBuilder: (context) {
          return items.map(
            (item) {
              return Text(
                selectedItems.map((e) => e.name).join(', '),
                style: Styles.semiBoldPoppins12,
                maxLines: 1,
              );
            },
          ).toList();
        },
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          iconSize: 16,
          iconEnabledColor: AppColors.grey,
        ),
        isExpanded: true,
        hint: Text(
          'Search for author',
          style: Styles.regularPoppins12.copyWith(color: AppColors.grey),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            //disable default onTap to avoid closing menu when selecting an item
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = selectedItems.contains(item);
                return InkWell(
                  onTap: () {
                    if (isSelected) {
                      selectedItems.remove(item);
                    } else {
                      selectedItems.add(item);
                    }
                    widget.authorsList!(
                        selectedItems.map((e) => e.name).toList());

                    setState(() {});
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: item,
                );
              },
            ),
          );
        }).toList(),

        value: selectedItems.isEmpty ? null : selectedItems.last,
        onChanged: (value) {},
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
                hintStyle: Styles.regularPoppins12
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

  OutlineInputBorder buildBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(14)),
    );
  }
}

// final List<AuthorModel> authors = [
//   // AuthorModel(
//   //     name: 'John Doe', image: 'https://randomuser.me/api/portraits/men/1.jpg'),
//   // AuthorModel(name: 'Mustafa Kamel', image: 'https://i.pravatar.cc/300?img=1'),
//   // AuthorModel(name: 'Ali Osama', image: 'https://i.pravatar.cc/300?img=2'),
//   // AuthorModel(
//   //     name: 'Ibrahim Mohamed', image: 'https://i.pravatar.cc/300?img=3'),
//   // AuthorModel(name: 'Karim Salah', image: 'https://i.pravatar.cc/300?img=4'),
// ];
