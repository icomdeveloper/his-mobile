import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';

class UserVideosRepo {
  final ApiServices apiServices;

  UserVideosRepo({required this.apiServices});

  Future<Either<Failure, List<MediaModel>>> userVideosPending() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.userVideos,
          // data: {ApiEndpoints.userId: getUserData().userInfo!.id},
          token: getUserData().token);
      Map<String, dynamic> mediaData = data['data'];
      List<dynamic> pendingMediaData = mediaData['pending'];
      if (pendingMediaData[0] is List) return const Right([]);

      List<MediaModel> list =
          pendingMediaData.map((e) => MediaModel.fromJson(e)).toList();
      return right(list);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<Failure, List<MediaModel>>> userVideos() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.userVideos,
          // data: {ApiEndpoints.userId: getUserData().userInfo!.id},
          token: getUserData().token);
      Map<String, dynamic> mediaData = data['data'];
      List<dynamic> publishedMediaData = mediaData['published'];
      if (publishedMediaData[0] is List) return const Right([]);

      List<MediaModel> list =
          publishedMediaData.map((e) => MediaModel.fromJson(e)).toList();
      return right(list);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
