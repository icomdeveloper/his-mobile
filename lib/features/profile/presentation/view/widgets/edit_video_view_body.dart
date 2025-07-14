import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/category/presentation/view/widgets/pdf_and_image_container.dart';
import 'package:his/features/category/presentation/view/widgets/pdf_view.dart';
import 'package:his/features/category/presentation/view/widgets/show_image_widget.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/utils/assets.dart';

class EditVideoViewBody extends StatefulWidget {
  const EditVideoViewBody({super.key, required this.mediaModel});
  final MediaModel mediaModel;

  @override
  State<EditVideoViewBody> createState() => _EditVideoViewBodyState();
}

class _EditVideoViewBodyState extends State<EditVideoViewBody> {
  bool isPickerActive = false;
  PlatformFile? pdfFile, imageFile;
  bool isFromFile = false;

  HtmlEditorController descriptionController = HtmlEditorController();
  TextEditingController titleController = TextEditingController();

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
          hintText: widget.mediaModel.title ?? '',
          isSearch: false,
          controller: titleController,
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
        SizedBox(
          height: 200.h,
          child: HtmlEditor(
            controller: descriptionController,
            htmlEditorOptions: HtmlEditorOptions(
              hint: widget.mediaModel.description ?? '',
            ),
            htmlToolbarOptions: const HtmlToolbarOptions(
              defaultToolbarButtons: [
                StyleButtons(),
                FontButtons(),
                ColorButtons(),
                ListButtons(),
                ParagraphButtons(),
              ],
            ),
            // otherOptions: const OtherOptions(
            //   height: 400,
            // ),
          ),
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
        widget.mediaModel.pdf != null
            ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => PdfView(
                                url: widget.mediaModel.pdf!,
                                isFromFile: isFromFile,
                              )));
                },
                child: PDFAndImageContainer(
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
                        InkWell(
                          onTap: () =>
                              setState(() => widget.mediaModel.pdf = null),
                          child: SvgPicture.asset(
                            Assets.assetsImagesDelete,
                            colorFilter: const ColorFilter.mode(
                                Color(0xffBB1313), BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 12),
        widget.mediaModel.image != null
            ? ShowImageWidget(
                image: widget.mediaModel.image!,
                errorWidget: (context, url, error) => Image.file(
                  File(widget.mediaModel.image!),
                ),
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
                      InkWell(
                        onTap: () =>
                            setState(() => widget.mediaModel.image = null),
                        child: SvgPicture.asset(
                          Assets.assetsImagesDelete,
                          colorFilter: const ColorFilter.mode(
                              Color(0xffBB1313), BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 12,
        ),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: EdgeInsets.zero,
          color: AppColors.lightGrey,
          dashPattern: const [5, 5],
          child: InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                backgroundColor: Colors.white,
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                    'Choose File',
                    style: Styles.semiBoldPoppins20,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          imageFile = await selectFile(type: FileType.image);
                          widget.mediaModel.image = imageFile!.path;
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1)),
                          ),
                          child: Text(
                            'Image',
                            style: Styles.semiBoldPoppins14.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          pdfFile = await selectFile(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'doc', 'docx']);
                          widget.mediaModel.pdf = pdfFile!.path;
                          isFromFile = true;
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                    color: AppColors.primaryColor, width: 1)),
                          ),
                          child: Text(
                            'PDF',
                            style: Styles.semiBoldPoppins14.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
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

  Future selectFile(
      {required FileType type, List<String>? allowedExtensions}) async {
    if (isPickerActive || !mounted) return null;

    try {
      isPickerActive = true;
      if (mounted) setState(() {});

      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
      );
      if (!mounted) return null;

      if (result == null) return null;
      if (mounted) setState(() {});
      return result.files.first;
    } on PlatformException catch (e) {
      if (mounted) {
        Fluttertoast.showToast(msg: e.message ?? 'Something went wrong');
      }
      return null;
    } finally {
      isPickerActive = false;
    }
  }
}
