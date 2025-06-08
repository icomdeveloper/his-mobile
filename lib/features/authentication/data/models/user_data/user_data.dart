import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'user_info.dart';

class UserData {
  String? message;
  UserInfo? userInfo;
  String? token;
  UserData({this.message, this.userInfo, this.token});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        message: json['message'] as String?,
        userInfo: json['user'] == null
            ? null
            : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  factory UserData.fromFirebase(auth.User user) => UserData(
        message: '',
        userInfo: UserInfo.fromFirebase(user),
        token: '',
      );
  Map<String, dynamic> toJson() =>
      {'message': message, 'user': userInfo?.toJson(), 'token': token};
}
