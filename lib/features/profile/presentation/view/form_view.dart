import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/core/widgets/custom_error_widget.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/presentation/cubits/user_form_cubit/user_form_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/author_contributions.dart';
import 'package:his/features/profile/presentation/view/widgets/author_info.dart';
import 'package:his/features/profile/presentation/view/widgets/form_item.dart';

class FormView extends StatelessWidget {
  const FormView({super.key, required this.formId});
  final String formId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context, title: 'My Videos'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<UserFormCubit, UserFormState>(
            builder: (context, state) {
              if (state is UserFormFailure) {
                return Center(
                    child: CustomErrorWidget(
                  errorMessage: state.errMesage,
                  onTap: () {
                    context.read<UserFormCubit>().getUserForm(id: formId);
                  },
                ));
              }

              if (state is UserFormSuccess) {
                List<Map<String, dynamic>> formItems = [
                  {
                    'title': 'Author Information',
                    'subTitle': null,
                    'data': AuthorInfo(
                      userFormModel: state.userFormModel,
                    )
                  },
                  {
                    'title': 'Authors’ Contributions',
                    'subTitle':
                        'Please outline the contribution of each author using initials.',
                    'data': AuthorContributions(
                      userFormModel: state.userFormModel,
                    ),
                  },
                  {
                    'title': 'Acknowledgements',
                    'subTitle':
                        'Acknowledge any individual, department, or organisation who contributed but is not listed as an author.',
                    'data': CustomTextField(
                      isSearch: false,
                      maxLines: 4,
                      hintText: state.userFormModel.acknowledgements ?? '',
                    )
                  },
                  {
                    'title': 'Declarations',
                    'subTitle': 'Consent to participate/publish ',
                    'data': declarationsRadioButton(
                      title: state.userFormModel.declarations ?? '',
                    )
                  },
                  {
                    'title': 'Institutional / Ethical approval',
                    'subTitle': null,
                    'data': ethicalApprovalInstitution(
                      title:
                          state.userFormModel.ethicalApprovalInstitution ?? '',
                    )
                  },
                ];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text.rich(TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Author Details Submission Form',
                            style: Styles.semiBoldPoppins16),
                        TextSpan(
                            text: '*',
                            style: Styles.semiBoldPoppins16
                                .copyWith(color: const Color(0xffBB1313))),
                      ],
                    )),
                    SizedBox(
                      height: 12.h,
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => FormItem(
                              index: index + 1,
                              subtitle: formItems[index]['subTitle'],
                              title: formItems[index]['title'],
                              data: formItems[index]['data']),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: formItems.length),
                    )
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}

// List<Map<String, dynamic>> formItems = [
//   {'title': 'Author Information', 'subTitle': null, 'data': const AuthorInfo()},
//   {
//     'title': 'Authors’ Contributions',
//     'subTitle':
//         'Please outline the contribution of each author using initials.',
//     'data': const AuthorContributions(),
//   },
//   {
//     'title': 'Acknowledgements',
//     'subTitle':
//         'Acknowledge any individual, department, or organisation who contributed but is not listed as an author.',
//     'data': const CustomTextField(
//       isSearch: false,
//       maxLines: 4,
//       hintText:
//           'e.g . Doctor hassan for surgical assistance, department of ....',
//     )
//   },
//   {
//     'title': 'Declarations',
//     'subTitle': 'Consent to participate/publish ',
//     'data': declarationsRadioButton()
//   },
//   {
//     'title': 'Institutional / Ethical approval',
//     'subTitle': null,
//     'data': ethicalApprovalInstitution()
//   },
// ];

declarationsRadioButton({required String title}) {
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
      children: [
        Row(children: [
          Radio(
            activeColor: AppColors.primaryColor,
            value: title ==
                'Informed consent obtained from the patient(s) or legal guardian(s) for use of clinical materials, images, and video',
            groupValue: true,
            onChanged: (value) {},
          ),
          const Expanded(
            child: Text(
              'Informed consent obtained from the patient(s) or legal guardian(s) for use of clinical materials, images, and video',
              style: Styles.regularPoppins12,
            ),
          )
        ]),
        Row(children: [
          Radio(
            activeColor: AppColors.primaryColor,
            value: title == 'Not applicable (no identifiable patient data).',
            groupValue: true,
            onChanged: (value) {},
          ),
          const Expanded(
            child: Text(
              'Not applicable (no identifiable patient data).',
              style: Styles.regularPoppins12,
            ),
          )
        ]),
      ],
    ),
  );
}

ethicalApprovalInstitution({required String title}) {
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
      children: [
        Row(children: [
          Radio(
            activeColor: AppColors.primaryColor,
            value: title ==
                'Approval granted by ___________ (institutional review board / equivalent)',
            groupValue: true,
            onChanged: (value) {},
          ),
          const Expanded(
            child: Text(
              'Approval granted by ___________ (institutional review board / equivalent)',
              style: Styles.regularPoppins12,
            ),
          )
        ]),
        Row(children: [
          Radio(
            activeColor: AppColors.primaryColor,
            value: title ==
                'Not applicable for educational content / anonymised retrospective case',
            groupValue: true,
            onChanged: (value) {},
          ),
          const Expanded(
            child: Text(
              'Not applicable for educational content / anonymised retrospective case',
              style: Styles.regularPoppins12,
            ),
          )
        ]),
      ],
    ),
  );
}
