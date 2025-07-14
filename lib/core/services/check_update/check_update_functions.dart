import 'dart:io';
import 'package:flutter/material.dart';
import '../api_services.dart'; // your Dio service
import 'force_update.dart'; // your force update screen

class CheckUpdateService {
  final ApiServices apiServices;

  // Inject the service via constructor
  CheckUpdateService({required this.apiServices});

  // Define your current app version here or pass dynamically
  static const String androidVersion = "1";
  static const String iosVersion = "1";

  static Future<void> check(
      BuildContext context, ApiServices apiServices) async {
    try {
      final response = await apiServices.getMethod(endPoint: 'check-update');

      // response is already decoded when using Dio
      final data = response['data'];
      if (data == null) {
        print("❌ Invalid response: no data field.");
        return;
      }

      final String apiVersion = Platform.isIOS
          ? data['ios_version'].toString() ?? ''
          : data['android_version'].toString() ?? '';

      final String localVersion = Platform.isIOS ? iosVersion : androidVersion;

      final bool isForcedUpdate = Platform.isIOS
          ? (data['ios'] ?? 0) == 1
          : (data['android'] ?? 0) == 1;

      final String updateUrl =
          Platform.isIOS ? data['ios_link'] ?? '' : data['android_link'] ?? '';

      if (isForcedUpdate && apiVersion != localVersion) {
        print("🔁 Update required: $apiVersion != $localVersion");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ForceYpdate(
              UpdateURL: updateUrl,
              apiServices: apiServices,
            ),
          ),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print('❌ Error checking for update: $e');
    }
  }
}
