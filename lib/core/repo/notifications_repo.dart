import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:his/constants.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/models/notifcation_model/notifcation_model.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';

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

  Future<Either<Failure, List<NotifcationModel>>> getNotifications(
      {required BuildContext context}) async {
    try {
      final response = await apiServices.getMethod(
          endPoint: ApiEndpoints.notifications, token: getUserData().token);
      List<dynamic> data = response['data'];
      return right(data.map((e) => NotifcationModel.fromJson(e)).toList());
    } on DioException catch (e) {
      if (e.response?.data['message'] == 'Unauthenticated.') {
        Prefs.setBool(PrefsKeys.isLoggedIn, false);
        await removeUserData();
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          (route) => false,
        );
        return Left(ServerFailure(
            errMesage: 'You are not authurized to make this request !'));
      }

      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
