import 'package:his/core/utils/api_endpoints.dart';

class LoginModel {
  final String userName;
  final String password;

  LoginModel({required this.userName, required this.password});
  toJson() =>
      {ApiEndpoints.userName: userName, ApiEndpoints.password: password};
}
