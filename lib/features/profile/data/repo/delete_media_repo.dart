import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';

class DeleteMediaRepo {
  final ApiServices apiServices;
  DeleteMediaRepo({required this.apiServices});

  Future<Either<Failure, String>> deleteMedia({required int mediaId}) async {
    try {
      final data = {
        ApiEndpoints.userId: getUserData().userInfo!.id,
        ApiEndpoints.mediaId: mediaId
      };
      final response = await apiServices.deleteMethod(
          endPoint: ApiEndpoints.deleteMedia, data: data);
      return Right(response['message']);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
