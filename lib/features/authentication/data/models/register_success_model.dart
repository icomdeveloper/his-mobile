class RegisterSuccessModel {
  final String message;
  final String success;

  RegisterSuccessModel({
    required this.message,
    required this.success,
  });

  factory RegisterSuccessModel.fromJson(Map<String, dynamic> json) {
    return RegisterSuccessModel(
      message: json['message'],
      success: json['success'],
    );
  }
}
