import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:his/features/authentication/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:his/features/authentication/presentation/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<AuthRepo>()),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: LoginViewBody()),
      ),
    );
  }
}
