import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:his/constants.dart';
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
import 'core/services/notifications/push_notifications.dart';
import 'features/on_boarding/presentation/view/on_boarding_view.dart';
import 'dart:convert';

/// Runs in a background isolate when the app is not in the foreground
@pragma('vm:entry-point')
Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PushNotifications.showSimpleNotification(
    title:
        message.data['title'] ?? message.notification?.title ?? 'Notification',
    body: message.data['body'] ?? message.notification?.body ?? '',
    payload: jsonEncode(message.data),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Prefs.init();
  Bloc.observer = CustomBlocObserver();
  setupGetIt();

  // One‑time permission and engine setup
  await PushNotifications.init();
  await PushNotifications.localNotiInit();

  // iOS foreground presentation
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Foreground listener
  FirebaseMessaging.onMessage.listen((m) {
    PushNotifications.showSimpleNotification(
      title: m.data['title'] ?? m.notification?.title ?? 'Notification',
      body: m.data['body'] ?? m.notification?.body ?? '',
      payload: jsonEncode(m.data),
    );
  });

  // Background / terminated (Android + iOS background)
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  //log('${getUserData().userInfo!.id??""})}');
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          navigatorKey: navigatorKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: onGenerateRoute,
          initialRoute: Prefs.getBool(PrefsKeys.isOnBoardingSeen)
              ? MainView.routeName
              : OnBoardingView.routeName,
          // home: AppEntryPoint(), // ✅ Entry point where we trigger update check

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CheckUpdateService.check(context, apiServices);
    });

    // While checking, show a blank screen and let routing continue normally
    final bool seenOnBoarding = Prefs.getBool(PrefsKeys.isOnBoardingSeen);
    return seenOnBoarding ? const MainView() : const OnBoardingView();
  }
}
