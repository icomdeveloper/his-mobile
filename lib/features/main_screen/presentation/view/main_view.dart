import 'package:flutter/material.dart';
import 'package:his/core/helpers/indexed_stack_provider.dart';
import 'package:his/features/main_screen/presentation/view/widgets/main_view_body.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const routeName = '/main-screen';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IndexStackProvider(),
      child: const MainViewBody(),
    );
  }
}
