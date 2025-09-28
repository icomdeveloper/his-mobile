import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';

import '../../../../core/utils/api_endpoints.dart';

class EditProfileRepo {
  final ApiServices apiServices;

  EditProfileRepo({required this.apiServices});

  Future<Either<Failure, dynamic>> editProfile(
      {required UserInformation userUpdates}) async {
    try {
      Map<String, dynamic> data = {
        ApiEndpoints.name: userUpdates.name,
        ApiEndpoints.phone: userUpdates.phone,
        ApiEndpoints.email: getUserData().userInfo?.email,
        ApiEndpoints.academicTitle: userUpdates.academicTitle,
        ApiEndpoints.department: userUpdates.department,
        ApiEndpoints.institution: userUpdates.institution,
        ApiEndpoints.countryOfGraduation: userUpdates.countryOfGraduation,
        ApiEndpoints.countryOfPractices: userUpdates.countryOfPractices,
        ApiEndpoints.yearOfGraduation: userUpdates.yearOfGraduation,
        ApiEndpoints.jobDescription: userUpdates.jobDescription,
        ApiEndpoints.userId: getUserData().userInfo?.id
      };
      final response = await apiServices.putMethod(
        endPoint: ApiEndpoints.updateProfile,
        token: getUserData().token,
        data: data,
      );
      // await updateUserInfo(
      //     userInfo: UserInformation.fromJson(response['user']));
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
