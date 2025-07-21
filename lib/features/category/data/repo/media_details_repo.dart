import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';

class MediaDetailsRepo {
  final ApiServices apiServices;
  MediaDetailsRepo({required this.apiServices});

  Future<Either<Failure, MediaModel>> getMediaDetails(
      {required int mediaId}) async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.mediaDetails,
          data: {
            ApiEndpoints.mediaId: mediaId,
            ApiEndpoints.userId: getUserData().userInfo!.id
          },
          token: getUserData().token);
      List<dynamic> dataList = data['data'];
      return right(MediaModel.fromJson(dataList[0]));
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
