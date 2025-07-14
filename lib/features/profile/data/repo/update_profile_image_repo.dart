import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/helpers/get_user_data.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';

class UpdateProfileImageRepo {
  final ApiServices apiServices;
  UpdateProfileImageRepo({required this.apiServices});

  Future<Either<Failure, UserInformation>> updateProfileImage({
    required File imageFile,
  }) async {
    try {
      final image = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      );
      FormData formData = FormData.fromMap({
        ApiEndpoints.userId: getUserData().userInfo!.id,
        'profile_image': image
      });
      final response = await apiServices.putMethod(
          endPoint: ApiEndpoints.updateProfileImage,
          data: formData,
          isFormData: true);
      return Right(UserInformation.fromJson(response['user']));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
