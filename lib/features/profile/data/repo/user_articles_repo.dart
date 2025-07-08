import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/home/data/models/article_model.dart';

class UserArticlesRepo {
  final ApiServices apiServices;

  UserArticlesRepo({required this.apiServices});

  Future<Either<Failure, List<ArticleModel>>> userArticles() async {
    try {
      final data = await apiServices.getMethod(
          endPoint: ApiEndpoints.userArticles,
          data: {ApiEndpoints.userId: getUserData().userInfo!.id});
      List<dynamic> articlesData = data['data'];
      List<ArticleModel> list =
          articlesData.map((e) => ArticleModel.fromJson(e)).toList();
      return right(list);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
