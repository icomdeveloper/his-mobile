import 'user_model.dart';

class RegisterSuccessModel {
  String? message;
  UserModel? user;

  RegisterSuccessModel({this.message, this.user});

  factory RegisterSuccessModel.fromJson(Map<String, dynamic> json) {
    return RegisterSuccessModel(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
      };
}
