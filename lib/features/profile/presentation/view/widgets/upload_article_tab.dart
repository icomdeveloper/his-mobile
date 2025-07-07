import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/data/model/upload_article_model.dart';
import 'package:his/features/profile/presentation/cubits/upload_article_cubit/upload_article_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/choose_file_button.dart';
import 'package:his/features/profile/presentation/view/widgets/custom_drop_down_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/features/profile/presentation/view/widgets/date_drop_down_button.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../cubits/upload_media_cubit/upload_media_cubit.dart';

class UploadArticleTab extends StatefulWidget {
  const UploadArticleTab({super.key});

  @override
  State<UploadArticleTab> createState() => _UploadArticleTabState();
}

class _UploadArticleTabState extends State<UploadArticleTab> {
  PlatformFile? pdfFile, imageFile;
  List<String> authors = [];
  bool isSelecting = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController titleController = TextEditingController();
  TextEditingController hyperlinkController = TextEditingController();
  bool isPickerActive = false;
  String? selectedYear;
  String? selectedMonth;
  bool isFeatured = false;
  HtmlEditorController descriptionController = HtmlEditorController();

  @override
  void dispose() {
    titleController.dispose();
    hyperlinkController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Upload image',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(
              height: 4,
            ),
            CustomTextField(
              hintText: 'Select your image ',
              isSearch: false,
              controller: TextEditingController(text: imageFile?.name ?? ''),
              readOnly: true,
              suffixIcon: ChooseFileButton(
                onTapped: () async {
                  imageFile = await selectFile(type: FileType.image);
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Upload PDF',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(
              height: 4,
            ),
            CustomTextField(
              hintText: 'Select your PDF ',
              isSearch: false,
              readOnly: true,
              controller: TextEditingController(text: pdfFile?.name ?? ''),
              suffixIcon: ChooseFileButton(
                onTapped: () async {
                  pdfFile = await selectFile(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'doc', 'docx']);
                },
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select Author',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            CustomDropDownButton(
              authorsList: (value) {
                authors = value;
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Year',
                      style: Styles.semiBoldPoppins14,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DateDropDownButton(
                          valueSelected: (value) {
                            setState(() {
                              selectedYear = value;
                            });
                          },
                        ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select month',
                      style: Styles.semiBoldPoppins14,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DateDropDownButton(
                        valueSelected: (value) {
                          setState(() {
                            selectedMonth = value;
                          });
                        },
                        isMonth: true,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Title',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            CustomTextFormField(
              hintText: 'Write your title here ..',
              controller: titleController,
              isSearch: false,
            ),
            const SizedBox(height: 12),
            const Text(
              'Add Description',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 400.h,
              child: HtmlEditor(
                controller: descriptionController,
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
            const SizedBox(height: 12),
            const Text(
              'Add Hyperlink',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            CustomTextFormField(
              hintText: 'Write your Link here ..',
              controller: hyperlinkController,
              isSearch: false,
              validator: (p0) {
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: isFeatured,
                  onChanged: (value) {
                    setState(() {
                      isFeatured = !isFeatured;
                    });
                  },
                ),
                const Text(
                  'Is Featured?',
                  style: Styles.semiBoldPoppins14,
                )
              ],
            ),
            const SizedBox(height: 24),
            BlocConsumer<UploadArticleCubit, UploadArticleState>(
              listener: (context, state) {
                if (state is UploadArticleSuccess) {
                  Fluttertoast.showToast(
                      msg: 'Your article uploaded successfully',
                      backgroundColor: const Color(0xFF0F8737));
                  Navigator.pop(context);
                }
                if (state is UploadArticleFailure) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
              builder: (context, state) {
                return state is UploadMediaLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomTextButton(
                        text: 'Upload Article',
                        onPressed: () async {
                          String description =
                              await descriptionController.getText();
                          if (description.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Please add description');
                          }
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            UploadArticleModel uploadArticleModel =
                                UploadArticleModel(
                                    userId: getUserData().userInfo!.id!,
                                    isFeatured: isFeatured ? 1 : 0,
                                    title: titleController.text,
                                    year: selectedYear!,
                                    month: selectedMonth!,
                                    description: description,
                                    hyperlink: hyperlinkController.text,
                                    imageFile: imageFile == null
                                        ? null
                                        : platformFileToFile(imageFile)!,
                                    pdfFile: pdfFile == null
                                        ? null
                                        : platformFileToFile(pdfFile)!);
                            context.read<UploadArticleCubit>().uploadArticle(
                                uploadArticleModel: uploadArticleModel);
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                        });
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
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

File? platformFileToFile(PlatformFile? platformFile) {
  if (platformFile == null) return null;

  if (platformFile.path == null) return null; // Not available on web
  return File(platformFile.path!);
}
