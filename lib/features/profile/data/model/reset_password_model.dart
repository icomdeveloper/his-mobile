class ResetPasswordModel {
  final String currentPassword;
  final String password;
  final String confirmPassword;
  final String email;
  final String token;

  ResetPasswordModel(
      {required this.currentPassword,
      required this.password,
      required this.confirmPassword,
      required this.email,
      required this.token});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      currentPassword: json['current_password'] ?? '',
      password: json['password'] ?? '',
      confirmPassword: json['password_confirmation'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
  toJson() => {
        'current_password': currentPassword,
        'password': password,
        'password_confirmation': confirmPassword,
        'email': email,
        'token': token
      };
}
