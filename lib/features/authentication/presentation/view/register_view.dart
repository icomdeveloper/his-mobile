import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:his/features/authentication/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:his/features/authentication/presentation/view/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(getIt<AuthRepo>()),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: RegisterViewBody()),
      ),
    );
  }
}
