import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({
    super.key,
  });

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
        Row(children: [
          getUserData().userInfo?.profileImage == null
              ? CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 23.r,
                    backgroundColor: const Color(0xffDBEEF2),
                    child:
                        const Icon(Icons.person, color: AppColors.primaryColor),
                  ),
                )
              : CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      NetworkImage(getUserData().userInfo!.profileImage!),
                  child: CircleAvatar(
                    radius: 23.r,
                    backgroundColor: const Color(0xffDBEEF2),
                    child:
                        const Icon(Icons.person, color: AppColors.primaryColor),
                  ),
                ),
          SizedBox(width: 12.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  getUserData().userInfo?.name ?? '',
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: Styles.semiBoldPoppins14.copyWith(color: Colors.white),
                ),
                Text(
                  getUserData().userInfo?.email ?? '',
                  style: Styles.regularPoppins14.copyWith(color: Colors.white),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ])
      ],
    );
  }
}
