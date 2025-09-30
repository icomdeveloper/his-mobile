import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/main.dart';
import 'package:his/notifications/presentation/notification_page.dart';

class PushNotifications {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutter =
      FlutterLocalNotificationsPlugin();

  /// New channel ID so Android recreates it with sound
  static const AndroidNotificationChannel _androidCh =
      AndroidNotificationChannel(
    'high_importance_v2', // <- NEW id
    'High Importance Notifications',
    description: 'Default channel with sound',
    importance: Importance.max,
    playSound: true,
    //sound: RawResourceAndroidNotificationSound('default'),
  );

  /*──────────────────────────  INITIALISATION  ─────────────────────────*/

  static Future<void> init() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.provisional) {
      return; // Permission denied
    }

    // Create (or update) the Android channel
    await _flutter
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidCh);

    // Helpful during debugging
    final fcmToken = await _messaging.getToken();
    Prefs.setString(PrefsKeys.fcmToken, fcmToken ?? '');

    log('FCM token: $fcmToken');
  }

  static Future<void> localNotiInit() async {
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
    );
    await _flutter.initialize(
      const InitializationSettings(android: initAndroid, iOS: initIOS),
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: handleNotificationTap,
    );
  }

  static Future<void> checkInitialMessage() async {
    // This gets the message that opened the app
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // If you only pass data from FCM directly
      if (initialMessage.data.isNotEmpty) {
        final payload = jsonEncode(initialMessage.data);
        _navigateToNotificationScreen(payload);
      }
    }
  }
  /*────────────────────────  LOCAL NOTIFICATION  ───────────────────────*/

  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final android = AndroidNotificationDetails(
      _androidCh.id,
      _androidCh.name,
      channelDescription: _androidCh.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,

      // sound: RawResourceAndroidNotificationSound('default'),
    );

    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    await _flutter.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
      title,
      body,
      NotificationDetails(android: android, iOS: ios),
      payload: payload,
    );
  }

  /*────────────────────────────  TAP HANDLER  ──────────────────────────*/

  // static void _onTap(NotificationResponse r) {
  //   log('Notification tapped with payload: ${r.payload}');
  // }

  static void handleNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        log("Notification tapped data: $data");

        // Decide navigation based on "type" or "id"
        _navigateToNotificationScreen(data);
      } catch (e, st) {
        log("Error decoding notification payload: $e\n$st");
      }
    }
  }

  static void _onTap(NotificationResponse r) {
    final payload = r.payload;
    if (payload != null && payload.isNotEmpty) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        log("Notification tapped data: $data");

        _navigateToNotificationScreen(data);
      } catch (e, st) {
        log("Error decoding notification payload: $e\n$st");
      }
    }
  }

  static void _navigateToNotificationScreen(dynamic data) {
    navigatorKey.currentState?.pushNamed(
      NotificationsPage.routeName,
      arguments: data,
    );
  }
}
