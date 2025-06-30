import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/profile/data/model/reset_password_model.dart';

class ResetPasswordRepo {
  final ApiServices apiServices;

  ResetPasswordRepo({required this.apiServices});
  Future<Either<Failure, dynamic>> resetPassword(
      {required ResetPasswordModel resetPasswordModel}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.resetPassword,
          data: resetPasswordModel.toJson());
      return right(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        return left(ServerFailure(
            errMesage: e.response?.data['errors']['current_password']));
      }
      return left(ServerFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
