import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/models/article_model.dart';

class ShowMediaRepo {
  final ApiServices apiServices;

  ShowMediaRepo({required this.apiServices});

  Future<Either<ServerFailure, List<MediaModel>>> showVideos() async {
    try {
      var data = await apiServices.getMethod(
          endPoint: ApiEndpoints.showMedia,
          token: getUserData().token,
          data: {ApiEndpoints.userId: getUserData().userInfo?.id});
      Map<String, dynamic> dataList = data['data'];
      List<dynamic> categories = dataList['categories'];
      final mediaList = categories
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
      var data = await apiServices.getMethod(
          endPoint: ApiEndpoints.showArticles,
          token: getUserData().token,
          data: {ApiEndpoints.userId: getUserData().userInfo?.id});
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

  Future<Either<ServerFailure, int>> incrementViewsCount(
      {required int mediaId}) async {
    try {
      var data = await apiServices
          .postMethod(endPoint: ApiEndpoints.viewscount, data: {
        ApiEndpoints.mediaId: mediaId,
      });
      return right(data['views']);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(
          ServerFailure(errMesage: 'Something went wrong , Tap to try again'));
    }
  }
}
