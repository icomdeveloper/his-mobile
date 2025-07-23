import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';

class RecentlyAddedRepo {
  final ApiServices apiServices;

  RecentlyAddedRepo({required this.apiServices});

  Future<Either<ServerFailure, List<MediaModel>>> getRecentlyAddedVideos(
      {required BuildContext context}) async {
    try {
      final response = await apiServices.getMethod(
        endPoint: ApiEndpoints.recentlyAdded,
        token: getUserData().token,
        // data: {ApiEndpoints.userId: getUserData().userInfo?.id},
      );
      List<dynamic> dataList = response['data'];
      final mediaList = dataList
          .expand((category) => (category['media'] as List)
              .map((mediaJson) => MediaModel.fromJson(mediaJson)))
          .toList();
      return Right(mediaList);
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return Left(
            ServerFailure(errMesage: 'Something went wrong , try again'));
      } else if (e.response?.data['message'] == 'Unauthenticated.') {
        // Prefs.setBool(PrefsKeys.isLoggedIn, false);
        // await removeUserData();
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => const LoginView(),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) =>
        //             SlideTransition(
        //       position: Tween<Offset>(
        //         begin: const Offset(1, 0),
        //         end: Offset.zero,
        //       ).animate(animation),
        //       child: child,
        //     ),
        //   ),
        //   (route) => false,
        // );
        return Left(ServerFailure(
            errMesage: 'You are not authurized to make this request !'));
      }
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
