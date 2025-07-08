import 'package:flutter/material.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/utils/assets.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/profile/presentation/view/widgets/user_data_row_widget.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UserDataRowWidget(
      onTap: () {
        showDialog(
            useRootNavigator: false,
            context: context,
            builder: (_) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text(
                      ' Log out of your account ?',
                      style: Styles.semiBoldPoppins16,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: Styles.semiBoldPoppins14
                              .copyWith(color: AppColors.darkGrey),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            Prefs.setBool(PrefsKeys.isLoggedIn, false);
                            await removeUserData();
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => const LoginView(),
                                transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) =>
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
                          },
                          child: Text(
                            'Logout',
                            style: Styles.semiBoldPoppins14
                                .copyWith(color: const Color(0xFFD60000)),
                          ))
                    ]));
      },
      title: 'Log Out',
      image: Assets.assetsImagesLogout,
    );
  }
}
