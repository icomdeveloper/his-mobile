import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/category/data/model/categories/categories.dart';

class CategoriesRepo {
  final ApiServices apiServices;
  CategoriesRepo({required this.apiServices});

  Future<Either<Failure, List<Categories>>> getCategories() async {
    try {
      final response = await apiServices.getMethod(
          endPoint: ApiEndpoints.categories, token: getUserData().token);
      Map<String, dynamic> data = response['data'];
      List<dynamic> categoriesList = data['categories'];
      List<Categories> categories =
          categoriesList.map((e) => Categories.fromJson(e)).toList();
      return right(categories);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
