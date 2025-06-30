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
      FormData formData = FormData.fromMap({
        ApiEndpoints.userId: uploadVideoModel.userId,
        ApiEndpoints.year: uploadVideoModel.year,
        ApiEndpoints.month: uploadVideoModel.month,
        ApiEndpoints.title: uploadVideoModel.title,
        ApiEndpoints.description: uploadVideoModel.description,
        ApiEndpoints.isFeatured: uploadVideoModel.isFeatured,
      });

      if (uploadVideoModel.videoFile != null) {
        formData.files.add(MapEntry(
            ApiEndpoints.file,
            await MultipartFile.fromFile(uploadVideoModel.videoFile!.path,
                filename: uploadVideoModel.videoFile!.path.split('/').last)));
      }
      if (uploadVideoModel.thumbnailFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.thumbnail,
          await MultipartFile.fromFile(
            uploadVideoModel.thumbnailFile!.path,
            filename: uploadVideoModel.thumbnailFile!.path.split('/').last,
          ),
        ));
      }

      if (uploadVideoModel.imageFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.imagePath,
          await MultipartFile.fromFile(
            uploadVideoModel.imageFile!.path,
            filename: uploadVideoModel.imageFile!.path.split('/').last,
          ),
        ));
      }

      if (uploadVideoModel.pdfFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.pdf,
          await MultipartFile.fromFile(
            uploadVideoModel.pdfFile!.path,
            filename: uploadVideoModel.pdfFile!.path.split('/').last,
          ),
        ));
      }
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.uploadVideo, data: formData, isFormData: true);
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
