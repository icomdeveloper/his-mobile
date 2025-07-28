import 'package:his/constants.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/api_endpoints.dart';

class NotificationsRepo {
  final ApiServices apiServices;

  NotificationsRepo({required this.apiServices});

  Future<dynamic> sendFCMToken() async {
    final response = await apiServices.postMethodWithToken(
        endPoint: ApiEndpoints.notificationsFcmToken,
        data: {ApiEndpoints.fcmToken: Prefs.getString(PrefsKeys.fcmToken)},
        token: getUserData().token);

    return response['message'];
  }

  Future<dynamic> getNotifications() async {
    final response = await apiServices.getMethod(
        endPoint: ApiEndpoints.notifications, token: getUserData().token);
    return response['data'];
  }
}
