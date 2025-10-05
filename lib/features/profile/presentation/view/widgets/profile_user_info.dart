import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/helpers/images_format.dart';
import 'package:his/core/helpers/platformFile_to_file.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';

import '../../cubits/update_profile_image_cubit/update_profile_image_cubit.dart';

class ProfileUserInfo extends StatefulWidget {
  const ProfileUserInfo({
    super.key,
  });

  @override
  State<ProfileUserInfo> createState() => _ProfileUserInfoState();
}

class _ProfileUserInfoState extends State<ProfileUserInfo> {
  late UserData user;
  PlatformFile? image;

  @override
  initState() {
    user = getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: Styles.semiBoldPoppins20.copyWith(color: Colors.white),
        ),
        SizedBox(height: 12.h),
        BlocConsumer<UpdateProfileImageCubit, UpdateProfileImageState>(
          listener: (context, state) {
            if (state is UpdateProfileImageSuccess) {
              showCustomSnackBar(
                  message: 'Profile image updated',
                  context: context,
                  backgroundColor: const Color(0xFF0F8737));
              image = null;
            } else if (state is UpdateProfileImageFailure) {
              showCustomSnackBar(message: state.errMessage, context: context);
              image = null;
            }
          },
          builder: (context, state) {
            return state is UpdateProfileImageLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Row(children: [
                    image == null
                        ? InkWell(
                            onTap: () async {
                              image = await selectFile(type: FileType.image);
                            },
                            onLongPress: () {
                              if (getUserData().userInfo!.profileImage !=
                                  null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 220.h),
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: formatImageUrl(getUserData()
                                            .userInfo!
                                            .profileImage!),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: getUserData().userInfo!.profileImage == null
                                ? Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        radius: 26.r,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 23.r,
                                          backgroundColor:
                                              const Color(0xffDBEEF2),
                                          child: const Icon(Icons.person,
                                              color: AppColors.primaryColor),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -5.h,
                                        right: 0,
                                        left: 0,
                                        child: CircleAvatar(
                                          radius: 9.r,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 7.r,
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            child: const Icon(
                                              Icons.edit,
                                              size: 8,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : CircleAvatar(
                                    radius: 26.r,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage: CachedNetworkImageProvider(
                                      formatImageUrl(getUserData()
                                          .userInfo!
                                          .profileImage!),
                                    ),
                                  ),
                          )
                        : InkWell(
                            onTap: () async {
                              final result =
                                  await selectFile(type: FileType.image);
                              if (result != null) {
                                setState(() {
                                  image = result;
                                });
                              }
                            },
                            child: CircleAvatar(
                              radius: 26.r,
                              backgroundColor: Colors.white,
                              backgroundImage: FileImage(File(image!.path!)),
                            ),
                          ),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            user.userInfo?.name ?? '',
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: Styles.semiBoldPoppins14
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            user.userInfo?.email ?? '',
                            style: Styles.regularPoppins14
                                .copyWith(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: image != null,
                        child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () {
                              final resultImage = platformFileToFile(image);
                              if (resultImage != null) {
                                context
                                    .read<UpdateProfileImageCubit>()
                                    .updateProfileImage(
                                      imageFile: resultImage,
                                    );
                              }
                            },
                            child: const Icon(
                              Icons.upgrade,
                              color: AppColors.primaryColor,
                            ))),
                    const SizedBox(width: 12),
                  ]);
          },
        ),
      ],
    );
  }

  Future selectFile(
      {required FileType type, List<String>? allowedExtensions}) async {
    if (!mounted) return null;

    try {
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
    } finally {}
  }
}
