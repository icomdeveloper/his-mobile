import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/profile/data/model/upload_article_model.dart';

class UploadArticleRepo {
  final ApiServices apiServices;

  UploadArticleRepo({required this.apiServices});

  Future<Either<ServerFailure, dynamic>> uploadArticle(
      {required UploadArticleModel uploadArticleModel}) async {
    try {
      FormData formData = FormData.fromMap({
        ApiEndpoints.userId: uploadArticleModel.userId,
        ApiEndpoints.hyperlink: uploadArticleModel.hyperlink,
        ApiEndpoints.year: uploadArticleModel.year,
        ApiEndpoints.month: uploadArticleModel.month,
        ApiEndpoints.title: uploadArticleModel.title,
        ApiEndpoints.description: uploadArticleModel.description,
        ApiEndpoints.isFeatured: uploadArticleModel.isFeatured,
      });

      if (uploadArticleModel.imageFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.imagePath,
          await MultipartFile.fromFile(
            uploadArticleModel.imageFile!.path,
            filename: uploadArticleModel.imageFile!.path.split('/').last,
          ),
        ));
      }

      if (uploadArticleModel.pdfFile != null) {
        formData.files.add(MapEntry(
          ApiEndpoints.pdf,
          await MultipartFile.fromFile(
            uploadArticleModel.pdfFile!.path,
            filename: uploadArticleModel.pdfFile!.path.split('/').last,
          ),
        ));
      }
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.uploadArticle,
          data: formData,
          isFormData: true);
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
