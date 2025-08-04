import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';

class SelectCountryMenu extends StatefulWidget {
  const SelectCountryMenu({
    super.key,
  });

  @override
  State<SelectCountryMenu> createState() => _SelectCountryMenuState();
}

class _SelectCountryMenuState extends State<SelectCountryMenu> {
  Country? selectedCountry;
  bool activeSelectedCountry = false;
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
              context.read<AuthCubit>().countryController.text = country.name;

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
            selectedCountry?.name ?? 'Select Country',
            style: Styles.regularPoppins12.copyWith(
              color: AppColors.grey,
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
