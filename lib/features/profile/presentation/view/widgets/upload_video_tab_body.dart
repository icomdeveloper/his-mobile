import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/helpers/platformFile_to_file.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/category/data/model/categories/categories.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:his/features/profile/data/model/upload_video_model.dart';
import 'package:his/features/profile/presentation/cubits/get_users_cubit/get_users_cubit.dart';
import 'package:his/features/profile/presentation/cubits/upload_media_cubit/upload_media_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/choose_file_button.dart';
import 'package:his/features/profile/presentation/view/widgets/custom_drop_down_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/features/profile/presentation/view/widgets/year_drop_down_button.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'month_drop_down_button.dart';

class UploadVideoTabBody extends StatefulWidget {
  const UploadVideoTabBody({super.key, required this.categories});
  final List<Categories> categories;

  @override
  State<UploadVideoTabBody> createState() => _UploadVideoTabBodyState();
}

class _UploadVideoTabBodyState extends State<UploadVideoTabBody> {
  PlatformFile? videoFile, thumbnailFile, pdfFile, imageFile;
  List<String>? mention;
  bool isSelecting = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController titleController = TextEditingController();
  bool isPickerActive = false;
  late String selectedMonth;
  late String selectedYear;
  late int yearIndex;
  bool isFeatured = false;
  late HtmlEditorController descriptionController;
  @override
  initState() {
    descriptionController = HtmlEditorController();
    selectedYear = widget.categories.first.name.toString();
    selectedMonth =
        widget.categories.first.subcategories!.first.name.toString();
    yearIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    monthValue = null;
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
                    decoration: const ShapeDecoration(
                        color: AppColors.lightPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        )),
                    child: InkWell(
                        onTap: () async {
                          if (mounted) {
                            setState(() => isSelecting = true);
                          }
                          videoFile = await selectFile(type: FileType.video);
                          if (mounted) {
                            setState(() => isSelecting = false);
                          }
                        },
                        child: isSelecting
                            ? Center(
                                child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 65.h, horizontal: 65.w),
                                child: const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ))
                            : videoFile == null
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 40.h),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            Assets.assetsImagesUpload),
                                        Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: 'Drag & drop files or ',
                                            style: Styles.semiBoldPoppins14
                                                .copyWith(
                                                    color: const Color(
                                                        0xff0F0F0F)),
                                          ),
                                          TextSpan(
                                            text: 'Browse',
                                            style: Styles.semiBoldPoppins14
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor),
                                          )
                                        ])),
                                        Text('Supported formates: videos only',
                                            style: Styles.regularRoboto10
                                                .copyWith(
                                                    color: AppColors.darkGrey))
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 40.h),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: 50.w,
                                            child: AspectRatio(
                                                aspectRatio: 1,
                                                child: SvgPicture.asset(Assets
                                                    .assetsImagesUploadVideo))),
                                        SizedBox(height: 16.h),
                                        Text(
                                          videoFile?.name ?? '',
                                          style: Styles.semiBoldPoppins14,
                                        )
                                      ],
                                    ),
                                  ))),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Upload thumbnail',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(
              height: 4,
            ),
            CustomTextFormField(
              hintText: 'Select your thumbnail image ',
              validator: (p0) {
                if (p0!.isEmpty || thumbnailFile == null) {
                  return 'Please select your thumbnail image';
                }
                return null;
              },
              controller:
                  TextEditingController(text: thumbnailFile?.name ?? ''),
              isSearch: false,
              readOnly: true,
              suffixIcon: ChooseFileButton(
                onTapped: () async {
                  thumbnailFile = await selectFile(type: FileType.image);
                },
              ),
            ),
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
                        child: YearDropDownButton(
                          yearList:
                              widget.categories.map((e) => e.name!).toList(),
                          valueSelected: (value) {
                            setState(() {
                              selectedYear = value!;
                              yearIndex = widget.categories.indexWhere(
                                  (element) => element.name == value);
                              log('YEAR index ===>> $yearIndex');
                              monthDropDownIndex = 0;
                              selectedMonth = widget.categories[yearIndex]
                                  .subcategories![monthDropDownIndex].name!;
                              monthValue = widget.categories[yearIndex]
                                  .subcategories![monthDropDownIndex].name!;
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
                      child: MonthDropDownButton(
                        monthList: widget.categories[yearIndex].subcategories!
                            .map((e) => e.name!)
                            .toList(),
                        valueSelected: (value) {
                          setState(() {
                            selectedMonth = value!;
                            log('MONTH index ===>> $monthDropDownIndex');
                            monthDropDownIndex = widget
                                .categories[yearIndex].subcategories!
                                .indexWhere((element) => element.name == value);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Select Author',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            BlocBuilder<GetUsersCubit, GetUsersState>(
                builder: (context, state) {
              if (state is GetUsersSuccess) {
                return CustomDropDownButton(
                  authors: state.users,
                  authorsList: (value) {
                    mention = value;
                    log('MENTION ===>> $mention');
                    log('MENTION encode ===>> ${jsonEncode(mention)}');
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your title';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            const Text(
              'Add Description',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 200.h,
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
            videoFile == null
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Uploading - 1/1 files',
                        style: Styles.semiBoldPoppins14
                            .copyWith(color: AppColors.grey),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(
                                width: 1,
                                color: AppColors.lightGrey,
                              )),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  videoFile?.name ?? '',
                                  style: Styles.regularRoboto12
                                      .copyWith(color: const Color(0xff0F0F0F)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    videoFile = null;
                                  });
                                },
                                child: const CircleAvatar(
                                  backgroundColor: AppColors.lightGrey,
                                  radius: 8,
                                  child: Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
              height: 12,
            ),
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
            BlocConsumer<UploadMediaCubit, UploadMediaState>(
              listener: (context, state) {
                if (state is UploadMediaSuccess) {
                  Fluttertoast.showToast(
                      msg: 'Video uploaded successfully',
                      backgroundColor: const Color(0xFF0F8737));

                  Navigator.pop(context);
                }
                if (state is UploadMediaFailure) {
                  Fluttertoast.showToast(msg: state.message);
                }
              },
              builder: (context, state) {
                return state is UploadMediaLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ))
                    : CustomTextButton(
                        text: 'Upload file',
                        onPressed: () async {
                          if (videoFile == null) {
                            Fluttertoast.showToast(
                                msg: 'Please select a video file');
                          }
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            UploadVideoModel uploadVideoModel =
                                UploadVideoModel(
                                    userId: getUserData().userInfo!.id!,
                                    year: selectedYear,
                                    month: selectedMonth,
                                    isFeatured: isFeatured ? 1 : 0,
                                    title: titleController.text,
                                    mention: mention,
                                    description:
                                        await descriptionController.getText(),
                                    videoFile: videoFile == null
                                        ? null
                                        : platformFileToFile(videoFile)!,
                                    imageFile: imageFile == null
                                        ? null
                                        : platformFileToFile(imageFile)!,
                                    thumbnailFile:
                                        platformFileToFile(thumbnailFile)!,
                                    pdfFile: pdfFile == null
                                        ? null
                                        : platformFileToFile(pdfFile)!);
                            context.read<UploadMediaCubit>().uploadVideo(
                                uploadVideoModel: uploadVideoModel);
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

String listToArrayString(List<String> list) {
  final quotedItems = list.map((item) => '"$item"').join(', ');
  return '"[$quotedItems]"';
}
