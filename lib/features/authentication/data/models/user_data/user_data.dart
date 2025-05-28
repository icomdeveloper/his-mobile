import 'user.dart';

class UserData {
  String? message;
  User? user;

  UserData({this.message, this.user});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        message: json['message'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
      };
}
