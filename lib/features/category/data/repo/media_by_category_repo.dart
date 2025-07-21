import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';

class MediaByCategoryRepo {
  final ApiServices apiServices;
  MediaByCategoryRepo({required this.apiServices});

  Future<Either<Failure, List<MediaModel>>> getMediaByCategory(
      {required int categoryId}) async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.categoryMedia,
          data: {
            ApiEndpoints.categoryId: categoryId,
            ApiEndpoints.userId: getUserData().userInfo?.id
          },
          token: getUserData().token);

      List<dynamic> mediaList = data['data'];
      List<MediaModel> list =
          mediaList.map((e) => MediaModel.fromJson(e)).toList();
      return right(list);
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return left(ServerFailure(errMesage: e.response?.data['error']));
      }
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
