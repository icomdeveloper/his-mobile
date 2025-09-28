import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/data/model/user_form_model.dart';

class AuthorContributions extends StatelessWidget {
  const AuthorContributions({super.key, required this.userFormModel});
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
              title: 'Conceptualisation',
              text: userFormModel.conceptualisation ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Surgical Procedure and Video',
              text: userFormModel.surgicalProcedureAndVideo ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Abstract Preparation',
              text: userFormModel.abstractPreparation ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Editing and Narration',
              text: userFormModel.editingAndNarration ?? ''),
          SizedBox(
            height: 12.h,
          ),
          _buildTextField(
              title: 'Final Approval', text: userFormModel.finalApproval ?? ''),
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
