import 'package:his/core/utils/api_endpoints.dart';

class LoginModel {
  final String login;
  final String password;

  LoginModel({required this.login, required this.password});
  toJson() => {ApiEndpoints.login: login, ApiEndpoints.password: password};
}
