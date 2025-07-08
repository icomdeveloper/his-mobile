import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/core/widgets/show_custom_snack_bar.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/profile/presentation/cubits/delete_user_cubit/delete_user_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_row_widget.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          useRootNavigator: false,
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            title: const Text(
              'Are you sure you want to delete your account ?',
              style: Styles.semiBoldPoppins20,
            ),
            content: const Text(
              'Deleting your account will permanently remove all your data, including your profile, posts, and any other information associated with your account .',
              style: Styles.regularPoppins14,
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                    side: const BorderSide(color: Color(0xFFD60000), width: 1)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Styles.regularPoppins14
                      .copyWith(color: const Color(0xFFD60000)),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
                  backgroundColor: const Color(0xFFD60000),
                ),
                onPressed: () {
                  context.read<DeleteUserCubit>().deleteUser();
                },
                child: Text(
                  'Delete',
                  style: Styles.regularPoppins14.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
      child: BlocListener<DeleteUserCubit, DeleteUserState>(
        listener: (context, state) async {
          if (state is DeleteUserSuccess) {
            showCustomSnackBar(
                message: state.message,
                context: context,
                backgroundColor: const Color(0xFF0F8737));
            Prefs.setBool(PrefsKeys.isLoggedIn, false);
            await removeUserData();
            Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const LoginView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              (route) => false,
            );
          }
          if (state is DeleteUserFailure) {
            showCustomSnackBar(
              message: state.errMessage,
              context: context,
            );
            Navigator.pop(context);
          }
        },
        child: const UserDataRowWidget(
          title: 'Delete Account',
          image: Assets.assetsImagesDelete,
        ),
      ),
    );
  }
}
