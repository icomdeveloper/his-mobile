import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:his/core/errors/failure.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';

class GetUsersRepo {
  final ApiServices apiServices;
  GetUsersRepo({required this.apiServices});

  Future<Either<Failure, List<UserInformation>>> getUsers() async {
    try {
      final response =
          await apiServices.getMethod(endPoint: ApiEndpoints.showMedia);
      Map<String, dynamic> data = response['data'];

      List<dynamic> users = data['users'];
      List<UserInformation> usersList =
          users.map((e) => UserInformation.fromJson(e)).toList();
      return Right(usersList);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(errMesage: 'Something went wrong , try again'));
    }
  }
}
