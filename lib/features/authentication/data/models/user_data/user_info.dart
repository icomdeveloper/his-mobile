import 'package:firebase_auth/firebase_auth.dart';

class UserInfo {
  int? id;
  String? name;
  String? email;
  String? username;
  String? deviceId;
  dynamic emailVerifiedAt;
  dynamic isReviewer;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.username,
    this.deviceId,
    this.emailVerifiedAt,
    this.isReviewer,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        username: json['username'] as String?,
        deviceId: json['device_id'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        isReviewer: json['is_reviewer'] as dynamic,
        role: json['role'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  factory UserInfo.fromFirebase(User user) => UserInfo(
        id: user.uid.hashCode,
        name: user.displayName ?? '',
        email: user.email ?? '',
        username: user.displayName ?? '',
        deviceId: '',
        emailVerifiedAt: '',
        isReviewer: '',
        role: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'username': username,
        'device_id': deviceId,
        'email_verified_at': emailVerifiedAt,
        'is_reviewer': isReviewer,
        'role': role,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
