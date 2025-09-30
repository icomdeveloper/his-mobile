import 'package:dio/dio.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/notifications/model/notifications_response.dart';

class NotificationService {
  final Dio _dio;
  final String baseUrl = 'https://his.mc-apps.org/api';
  NotificationService(this._dio);

  Future<NotificationResponse> getNotifications({
    String? nextPageUrl,
    int page = 1,
    int limit = 15,
  }) async {
    final response = await _dio.get(
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getUserData().token}',
        },
      ),
      nextPageUrl ?? '$baseUrl/notifications',
      queryParameters: nextPageUrl == null
          ? {'page': page, 'limit': limit}
          : {'limit': limit},
    );
    return NotificationResponse.fromJson(response.data);
  }

  Future<NotificationResponse> getUnreadNotifications(
      {String? nextPageUrl, int limit = 1, int page = 1}) async {
    final response = await _dio.get(
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getUserData().token}',
        },
      ),
      nextPageUrl ?? '$baseUrl/UnReadNotifications',
      queryParameters:
          nextPageUrl == null ? {'page': page, 'limit': limit} : null,
    );
    return NotificationResponse.fromJson(response.data);
  }

  Future<void> markAsRead(int notificationId) async {
    await _dio.post(
      '$baseUrl/markAsSeen',
      data: {
        'id': notificationId,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${getUserData().token}',
        },
      ),
    );
  }
}
