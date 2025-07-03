import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';

import '../../../../core/utils/api_endpoints.dart';

class EditProfileRepo {
  final ApiServices apiServices;

  EditProfileRepo({required this.apiServices});

  Future<Either<Failure, dynamic>> editProfile(
      {required String name, required String phone}) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "phone": phone,
        "email": getUserData().userInfo?.email,
        "user_id": getUserData().userInfo?.id
      };
      final response = await apiServices.putMethod(
          endPoint: ApiEndpoints.updateProfile, data: data);
      return Right(response['user']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return Left(ServerFailure(errMesage: e.response?.data['message']));
      }
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
