import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/features/notifications/presentation/view/notification_view.dart';
import 'package:his/main.dart';

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
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );
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
  static void handleNotificationTap(RemoteMessage message) {
    final payload = message.data['payload'] ?? '';
    _navigateToNotificationScreen(payload);
  }

  static void _onTap(NotificationResponse r) {
    log('Notification tapped with payload: ${r.payload}');
    _navigateToNotificationScreen(r.payload ?? '');
  }

  static void _navigateToNotificationScreen(String payload) {
    navigatorKey.currentState
        ?.pushNamed(NotificationView.routeName, arguments: payload);
  }
}
