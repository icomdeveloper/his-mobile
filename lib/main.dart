import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/helpers/nav_bar_visibility_provider.dart';
import 'package:his/core/services/app_routes.dart';
import 'package:his/core/services/custom_bloc_observer.dart';
import 'package:his/core/services/get_it.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/features/main_screen/presentation/view/main_view.dart';
import 'package:his/firebase_options.dart';
import 'package:provider/provider.dart';

import 'core/services/api_services.dart';
import 'core/services/check_update/check_update_functions.dart';
import 'features/on_boarding/presentation/view/on_boarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Prefs.init();
  Bloc.observer = CustomBlocObserver();
  setupGetIt();
  //log('${getUserData().userInfo!.id??""})}');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => ChangeNotifierProvider(

        create: (_) => NavBarVisibilityProvider(),
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          home: AppEntryPoint(), // ✅ Entry point where we trigger update check

          /* initialRoute: Prefs.getBool(PrefsKeys.isOnBoardingSeen)
              ? MainView.routeName
              : OnBoardingView.routeName,*/
        ),
      ),
    );
  }
}

class AppEntryPoint extends StatelessWidget {
  AppEntryPoint({super.key});

  final ApiServices apiServices = ApiServices(dio: Dio());

  @override
  Widget build(BuildContext context) {
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      CheckUpdateService.check(context, apiServices);
    });*/

    // While checking, show a blank screen and let routing continue normally
    final bool seenOnBoarding = Prefs.getBool(PrefsKeys.isOnBoardingSeen);
    return seenOnBoarding ? const MainView() : const OnBoardingView();
  }
}
