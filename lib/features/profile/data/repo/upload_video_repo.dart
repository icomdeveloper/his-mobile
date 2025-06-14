import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/profile/data/model/upload_video_model.dart';

class UploadVideoRepo {
  final ApiServices apiServices;

  UploadVideoRepo({required this.apiServices});

  Future<Either<ServerFailure, dynamic>> uploadVideo(
      {required UploadVideoModel uploadVideoModel}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.uploadVideo,
          data: uploadVideoModel.toJson(),
          isFormData: true);
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
