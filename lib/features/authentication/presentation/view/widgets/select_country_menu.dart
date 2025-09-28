import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';
import 'package:his/features/profile/presentation/cubits/edit_profile_cubit/edit_profile_cubit.dart';

class SelectCountryMenu extends StatefulWidget {
  const SelectCountryMenu({
    super.key,
    required this.flag,
    this.isFromRegister = true,
    this.countrySelectedBefore,
  });
  final bool flag;
  final bool isFromRegister;
  final String? countrySelectedBefore;
  @override
  State<SelectCountryMenu> createState() => _SelectCountryMenuState();
}

class _SelectCountryMenuState extends State<SelectCountryMenu> {
  Country? selectedCountry;
  bool activeSelectedCountry = false;
  String? countrySelectedBefore;
  @override
  void initState() {
    if (widget.countrySelectedBefore != '') {
      countrySelectedBefore = widget.countrySelectedBefore;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          activeSelectedCountry = true;
        });

        showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500, // Optional. Country list modal height
              //Optional. Sets the border radius for the bottomsheet.
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              //Optional. Styles the search field.
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onClosed: () {
              setState(() {
                activeSelectedCountry = false;
              });
            },
            onSelect: (Country country) {
              selectedCountry = country;
              if (widget.isFromRegister) {
                if (widget.flag) {
                  context.read<AuthCubit>().countryOfPractice.text =
                      country.name;
                } else {
                  context.read<AuthCubit>().countryOfGraduation.text =
                      country.name;
                }
              } else {
                if (widget.flag) {
                  context.read<EditProfileCubit>().countryOfPractice.text =
                      country.name;
                } else {
                  context.read<EditProfileCubit>().countryOfGraduation.text =
                      country.name;
                }
              }
              setState(() {});
            });
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 22.w,
          top: 14.h,
          bottom: 14.h,
          right: 8.w,
        ),
        decoration: const ShapeDecoration(
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 1, color: AppColors.lightGrey))),
        child: Row(children: [
          selectedCountry?.flagEmoji != null
              ? Text(
                  selectedCountry!.flagEmoji,
                )
              : const SizedBox.shrink(),
          const SizedBox(
            width: 10,
          ),
          Text(
            selectedCountry?.name ?? countrySelectedBefore ?? 'Select Country',
            style: Styles.regularPoppins12.copyWith(
              color: countrySelectedBefore != null
                  ? Colors.black
                  : selectedCountry?.name != null
                      ? Colors.black
                      : AppColors.grey,
            ),
          ),
          const Spacer(),
          Icon(
            activeSelectedCountry
                ? Icons.keyboard_arrow_up_outlined
                : Icons.keyboard_arrow_down_outlined,
            color: AppColors.grey,
          ),
        ]),
      ),
    );
  }
}
