import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/profile/data/model/edit_media_model.dart';

class EditMediaRepo {
  final ApiServices apiServices;

  EditMediaRepo({required this.apiServices});

  Future<Either<Failure, dynamic>> editMedia(
      {required EditMediaModel editMediaModel}) async {
    try {
      FormData formData = FormData.fromMap({
        ApiEndpoints.userId: editMediaModel.userId,
        ApiEndpoints.mediaId: editMediaModel.mediaId,
        ApiEndpoints.year: editMediaModel.year,
        ApiEndpoints.month: editMediaModel.month,
        ApiEndpoints.title: editMediaModel.title,
        ApiEndpoints.description: editMediaModel.description,
      });
      if (editMediaModel.videoFile != null) {
        formData.files.add(MapEntry(
            ApiEndpoints.file,
            await MultipartFile.fromFile(editMediaModel.videoFile!.path,
                filename: editMediaModel.videoFile!.path.split('/').last)));
      }
      if (editMediaModel.thumbnailFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.thumbnail,
          await MultipartFile.fromFile(
            editMediaModel.thumbnailFile!.path,
            filename: editMediaModel.thumbnailFile!.path.split('/').last,
          ),
        ));
      }
      if (editMediaModel.imageFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.imagePath,
          await MultipartFile.fromFile(
            editMediaModel.imageFile!.path,
            filename: editMediaModel.imageFile!.path.split('/').last,
          ),
        ));
      }

      if (editMediaModel.pdfFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.pdf,
          await MultipartFile.fromFile(
            editMediaModel.pdfFile!.path,
            filename: editMediaModel.pdfFile!.path.split('/').last,
          ),
        ));
      }

      final data = await apiServices.postMethod(
          endPoint: ApiEndpoints.editMedia, data: formData, isFormData: true);
      return right(data['message']);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
