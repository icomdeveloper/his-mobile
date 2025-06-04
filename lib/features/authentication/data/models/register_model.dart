import 'package:his/core/utils/api_endpoints.dart';

class RegisterModel {
  final String name;
  final String email;
  final String username;
  final String password;
  final String confirmPassword;
  final String role;
  final String phone;

  RegisterModel(
      {required this.name,
      required this.email,
      required this.username,
      required this.password,
      required this.confirmPassword,
      this.role = 'user',
      required this.phone});
  toJson() {
    return {
      ApiEndpoints.name: name,
      ApiEndpoints.email: email,
      ApiEndpoints.userName: username,
      ApiEndpoints.password: password,
      ApiEndpoints.passwordConfirmation: confirmPassword,
      ApiEndpoints.role: role,
      ApiEndpoints.phone: phone,
    };
  }
}
