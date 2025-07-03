import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';

class DeleteUserRepo {
  final ApiServices apiServices;
  DeleteUserRepo({required this.apiServices});
  Future<Either<Failure, dynamic>> deleteUser() async {
    try {
      var data = await apiServices
          .deleteMethod(endPoint: ApiEndpoints.deleteUser, data: {
        ApiEndpoints.userId: 22131,
        ApiEndpoints.email: getUserData().userInfo?.email,
      });
      return right(data);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(
          ServerFailure(errMesage: 'Something went wrong , Tap to try again'));
    }
  }
}
