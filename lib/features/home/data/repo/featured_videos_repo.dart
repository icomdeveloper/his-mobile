import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';

class FeaturedVideosRepo {
  final ApiServices apiServices;

  FeaturedVideosRepo({required this.apiServices});

  Future<Either<ServerFailure, List<MediaModel>>> getFeaturedVideos() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.featuredVideos,
          token: getUserData().token,
          data: {ApiEndpoints.userId: getUserData().userInfo?.id});
      List<dynamic> dataList = data['data'];
      final mediaList = dataList
          .expand((category) => (category['media'] as List)
              .map((mediaJson) => MediaModel.fromJson(mediaJson)))
          .toList();
      return right(mediaList);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
