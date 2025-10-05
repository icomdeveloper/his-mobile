import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/widgets/build_app_bar.dart';
import 'package:his/features/profile/data/repo/user_videos_repo.dart';
import 'package:his/features/profile/presentation/cubits/user_videos_cubit/user_videos_cubit.dart';
import 'package:his/features/profile/presentation/view/widgets/my_videos_view_body.dart';

class MyVideosView extends StatelessWidget {
  const MyVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, title: 'My Videos'),
      body: BlocProvider(
        create: (context) => UserVideosCubit(getIt<UserVideosRepo>()),
        child: const MyVideosViewBody(),
      ),
    );
  }
}
