import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/data/model/user_form_model.dart';

class AuthorInfo extends StatelessWidget {
  const AuthorInfo({super.key, required this.userFormModel});
  final UserFormModel userFormModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.lightGrey, width: 1),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
              title: 'Full academic name',
              text: userFormModel.fullAcademicName ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Academic title', text: userFormModel.academicTitle ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Given names (s)', text: userFormModel.givenNames ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(title: 'ORCID', text: userFormModel.orcid ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Professional Email',
              text: userFormModel.professionalEmail ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Institution', text: userFormModel.institution ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(title: 'City', text: userFormModel.city ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(title: 'Country', text: userFormModel.country ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title:
                  'Correspondence / Postal Address ( For corresponding Author )',
              text: userFormModel.correspondenceAddress ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Research Interesrts',
              text: userFormModel.researchInterests ?? ''),
        ],
      ),
    );
  }

  Column _buildTextField({required String title, required String text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Styles.semiBoldPoppins12),
        const SizedBox(
          height: 4,
        ),
        CustomTextField(
          isSearch: false,
          readOnly: true,
          hintText: text,
        ),
      ],
    );
  }
}
