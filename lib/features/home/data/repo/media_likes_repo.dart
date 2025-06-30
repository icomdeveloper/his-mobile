import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';

class MediaLikesRepo {
  final ApiServices apiServices;
  MediaLikesRepo({required this.apiServices});

  Future<Either<ServerFailure, dynamic>> addLike(
      {required int id, required String endPoint}) async {
    try {
      final data = await apiServices.postMethod(
          endPoint: '$endPoint/$id/like',
          data: {ApiEndpoints.userId: getUserData().userInfo!.id});
      return Right(data['message']);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }

  Future<Either<ServerFailure, dynamic>> deleteLike(
      {required int id, required String endPoint}) async {
    try {
      final data = await apiServices.deleteMethod(
          endPoint: '$endPoint/$id/like',
          data: {ApiEndpoints.userId: getUserData().userInfo!.id});
      return Right(data['message']);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
