import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/utils/app_colors.dart';
import 'package:his/core/utils/app_text_styles.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/data/repo/user_videos_repo.dart';
import 'package:his/features/profile/presentation/cubits/user_form_cubit/user_form_cubit.dart';
import 'package:his/features/profile/presentation/cubits/user_videos_cubit/user_videos_cubit.dart';
import 'package:his/features/profile/presentation/view/form_view.dart';
import 'package:his/features/profile/presentation/view/widgets/my_videos_view_body.dart';

class MyVideosView extends StatelessWidget {
  const MyVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'My Videos'),
      floatingActionButton: SizedBox(
        height: 40.h,
        width: 80.w,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          backgroundColor: AppColors.primaryColor,
          child: Text(
            'Show form',
            style: Styles.regularPoppins12.copyWith(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => BlocProvider(
                          create: (context) =>
                              UserFormCubit(getIt<UserVideosRepo>())
                                ..getUserForm(),
                          child: const FormView(),
                        ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                              opacity: animation,
                              child: child,
                            )));
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => UserVideosCubit(getIt<UserVideosRepo>()),
        child: const MyVideosViewBody(),
      ),
    );
  }
}
