import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:his/core/errors/exceptions.dart';
import 'package:his/core/errors/failures.dart';
import 'package:his/core/services/api_services.dart';
import 'package:his/core/utils/api_endpoints.dart';
import 'package:his/features/authentication/data/models/login_model.dart';

class LoginRepo {
  final ApiServices apiServices;

  LoginRepo({required this.apiServices});
  Future<Either<Failures, dynamic>> login(
      {required LoginModel loginModel}) async {
    try {
      var data = await apiServices.postMethod(
          endPoint: ApiEndpoints.login, data: loginModel.toJson());
      log('Step2 ==>$data');
      return right(data);
    } on Customexception catch (e) {
      return left(Failures(message: e.message));
    }
  }
}
