import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/models/article_model.dart';

class ShowMediaRepo {
  final ApiServices apiServices;

  ShowMediaRepo({required this.apiServices});

  Future<Either<ServerFailure, List<MediaModel>>> showVideos() async {
    try {
      var data = await apiServices.getMethod(endPoint: ApiEndpoints.showMedia);
      List<dynamic> dataList = data['data'];
      final mediaList = dataList
          .expand((category) => (category['media'] as List)
              .map((mediaJson) => MediaModel.fromJson(mediaJson)))
          .toList();
      return right(mediaList);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(
          ServerFailure(errMesage: 'Something went wrong , Tap to try again'));
    }
  }

  Future<Either<ServerFailure, List<ArticleModel>>> showArticles() async {
    try {
      var data =
          await apiServices.getMethod(endPoint: ApiEndpoints.showArticles);
      List<dynamic> articleData = data['data'];

      List<ArticleModel> list =
          articleData.map((e) => ArticleModel.fromJson(e)).toList();

      return right(list);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(
          ServerFailure(errMesage: 'Something went wrong , Tap to try again'));
    }
  }
}
