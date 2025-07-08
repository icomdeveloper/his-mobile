import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/view/widgets/pdf_and_image_container.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/assets.dart';

class EditVideoViewBody extends StatelessWidget {
  const EditVideoViewBody({super.key, required this.mediaModel});
  final MediaModel mediaModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edit Title',
          style: Styles.semiBoldPoppins14,
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextField(
          hintText: mediaModel.title ?? '',
          isSearch: false,
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Edit Description',
          style: Styles.semiBoldPoppins14,
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextField(
          hintText: mediaModel.description ?? '',
          isSearch: false,
          maxLines: 5,
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          'Attachments',
          style: Styles.semiBoldPoppins14,
        ),
        const SizedBox(
          height: 4,
        ),
        PDFAndImageContainer(
          title: 'Document',
          subTitle: 'PDF',
          trailingIcon: SizedBox(
            width: 50.w,
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.assetsImagesEdit,
                ),
                const SizedBox(
                  width: 12,
                ),
                SvgPicture.asset(
                  Assets.assetsImagesDelete,
                  colorFilter: const ColorFilter.mode(
                      Color(0xffBB1313), BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        PDFAndImageContainer(
          title: 'Image',
          subTitle: 'image',
          trailingIcon: SizedBox(
            width: 50.w,
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.assetsImagesEdit,
                ),
                const SizedBox(
                  width: 12,
                ),
                SvgPicture.asset(
                  Assets.assetsImagesDelete,
                  colorFilter: const ColorFilter.mode(
                      Color(0xffBB1313), BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: EdgeInsets.zero,
          color: AppColors.lightGrey,
          dashPattern: const [5, 5],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8),
                Text(
                  'Add Attachment',
                  style: Styles.semiBoldPoppins14,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        CustomTextButton(
          text: 'Delete Post',
          onPressed: () {},
          isArrowAppear: false,
        ),
        const SizedBox(height: 12),
        CustomTextButton(
          borderColor: AppColors.primaryColor,
          text: 'Cancel',
          backgroundColor: Colors.white,
          textColor: AppColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
          isArrowAppear: false,
        ),
      ],
    );
  }
}
