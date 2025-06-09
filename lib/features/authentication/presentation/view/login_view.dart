import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:his/core/helpers/nav_bar_visibility_provider.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/features/authentication/data/repo/auth_repo.dart';
import 'package:his/features/authentication/presentation/cubits/auth_Cubit/auth_cubit.dart';
import 'package:his/features/authentication/presentation/view/widgets/login_view_body.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late NavBarVisibilityProvider _navBarProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Store the provider reference when dependencies change
    _navBarProvider =
        Provider.of<NavBarVisibilityProvider>(context, listen: false);
    // Hide navbar when this view appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navBarProvider.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt<AuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: PopScope(
                canPop: true, // Prevents default back button behavior
                onPopInvokedWithResult: (bool didPop, _) async {
                  _navBarProvider.show();
                },
                child: const LoginViewBody())),
      ),
    );
  }
}
