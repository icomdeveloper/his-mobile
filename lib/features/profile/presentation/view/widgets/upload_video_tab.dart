import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_field.dart';

class UploadVideoTab extends StatelessWidget {
  const UploadVideoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          Center(
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: EdgeInsets.zero,
              color: AppColors.primaryColor,
              dashPattern: const [5, 5],
              child: Container(
                  width: MediaQuery.of(context).size.width - 48 - 10,
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  decoration: const ShapeDecoration(
                      color: AppColors.lightPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      )),
                  child: Column(
                    children: [
                      SvgPicture.asset(Assets.assetsImagesUpload),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'Drag & drop files or ',
                          style: Styles.semiBoldPoppins14
                              .copyWith(color: const Color(0xff0F0F0F)),
                        ),
                        TextSpan(
                          text: 'Browse',
                          style: Styles.semiBoldPoppins14
                              .copyWith(color: AppColors.primaryColor),
                        )
                      ])),
                      Text('Supported formates: JPEG, PNG, PDF',
                          style: Styles.regularRoboto10
                              .copyWith(color: const Color(0xff7B7B7B)))
                    ],
                  )),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Title',
            style: Styles.semiBoldPoppins14,
          ),
          const SizedBox(height: 4),
          const CustomTextField(
            hintText: 'Write your title here ..',
            isSearch: false,
          ),
          const SizedBox(height: 12),
          const Text(
            'Add Description',
            style: Styles.semiBoldPoppins14,
          ),
          const SizedBox(height: 4),
          const CustomTextField(
            hintText: 'Write your description here ..',
            isSearch: false,
            maxLines: 7,
          ),
          const SizedBox(height: 12),
          Text(
            'Uploading - 1/1 files',
            style: Styles.semiBoldPoppins14.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 24),
          CustomTextButton(text: 'Upload file', onPressed: () {}),
        ],
      ),
    );
  }
}
