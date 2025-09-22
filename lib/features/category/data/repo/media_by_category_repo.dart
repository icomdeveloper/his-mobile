import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:his/constants.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/presentation/view/login_view.dart';
import 'package:his/features/category/data/model/media_model.dart';

import '../../../../core/services/shared_preferences.dart';

class MediaByCategoryRepo {
  final ApiServices apiServices;
  MediaByCategoryRepo({required this.apiServices});

  Future<Either<Failure, List<MediaModel>>> getMediaByCategory(
      {required int categoryId, required BuildContext context}) async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.categoryMedia,
          data: {
            ApiEndpoints.subCategoryId: categoryId,
            ApiEndpoints.userId: getUserData().userInfo?.id
          },
          token: getUserData().token);

      List<dynamic> mediaList = data['data'];
      List<MediaModel> list =
          mediaList.map((e) => MediaModel.fromCategories(e)).toList();

      return right(list);
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return left(ServerFailure(errMesage: e.response?.data['message']));
      }
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
