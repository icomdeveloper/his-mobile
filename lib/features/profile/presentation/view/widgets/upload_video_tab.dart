import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/custom_text_button.dart';
import 'package:his/features/home/presentation/view/widgets/custom_text_field.dart';
import 'package:his/features/profile/presentation/view/widgets/custom_drop_down_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadVideoTab extends StatefulWidget {
  const UploadVideoTab({super.key});

  @override
  State<UploadVideoTab> createState() => _UploadVideoTabState();
}

class _UploadVideoTabState extends State<UploadVideoTab> {
  PlatformFile? file;
  bool isSelecting = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? category;

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
                          await selectFile();
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
                            : file == null
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
                                        Text('Supported formates: videos, GIF',
                                            style: Styles.regularRoboto10
                                                .copyWith(
                                                    color: const Color(
                                                        0xff7B7B7B)))
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
                                          file?.name ?? '',
                                          style: Styles.semiBoldPoppins14,
                                        )
                                      ],
                                    ),
                                  ))),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select category',
              style: Styles.semiBoldPoppins14,
            ),
            const SizedBox(height: 4),
            CustomDropDownButton(
              onChanged: (value) {
                setState(() {
                  category = value;
                });
              },
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
            file == null
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
                                  file?.name ?? '',
                                  style: Styles.regularRoboto12
                                      .copyWith(color: const Color(0xff0F0F0F)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    file = null;
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
            const SizedBox(height: 24),
            CustomTextButton(
                text: 'Upload file',
                onPressed: () {
                  if (file == null) {
                    if (category == null) {
                      Fluttertoast.showToast(
                        msg: 'Please select your video and category',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Please select your video',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }
                  } else if (category == null) {
                    Fluttertoast.showToast(
                      msg: 'Please select category',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    setState(() {
      isSelecting = true;
    });
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result == null) {
      setState(() {
        isSelecting = false;
      });
      return;
    }
    setState(() {
      file = result.files.first;
      isSelecting = false;
    });
  }
}
