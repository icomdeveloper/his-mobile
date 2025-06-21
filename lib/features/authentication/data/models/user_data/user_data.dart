import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'user_information.dart';

class UserData {
  String? message;
  UserInformation? userInfo;
  String? token;
  UserData({this.message, this.userInfo, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        message: json['message'] as String?,
        userInfo: json['user'] == null
            ? null
            : UserInformation.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  factory UserData.fromFirebase(auth.User user) => UserData(
        message: '',
        userInfo: UserInformation.fromFirebase(user),
        token: '',
      );
  Map<String, dynamic> toJson() =>
      {'message': message, 'user': userInfo?.toJson(), 'token': token};
}
