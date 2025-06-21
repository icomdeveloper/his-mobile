import 'package:firebase_auth/firebase_auth.dart';

class UserInformation {
  int? id;
  String? name;
  String? email;
  String? username;
  String? phone;
  dynamic emailVerifiedAt;
  dynamic isReviewer;
  String? role;
  String? googleId;
  String? appleId;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserInformation(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.username,
      this.emailVerifiedAt,
      this.isReviewer,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.googleId,
      this.appleId,
      this.deletedAt});

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        username: json['username'] as String?,
        phone: json['phone'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        isReviewer: json['is_reviewer'] as dynamic,
        role: json['role'] as String?,
        googleId: json['google_id'] as String?,
        appleId: json['apple_id'] as String?,
        deletedAt: json['deleted_at'] == null
            ? null
            : DateTime.parse(json['deleted_at'] as String),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  factory UserInformation.fromFirebase(User user) => UserInformation(
        id: user.uid.hashCode,
        name: user.displayName ?? '',
        email: user.email ?? '',
        username: user.displayName ?? '',
        emailVerifiedAt: '',
        isReviewer: '',
        role: '',
        googleId: '',
        appleId: '',
        phone: user.phoneNumber ?? '',
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'username': username,
        'email_verified_at': emailVerifiedAt,
        'is_reviewer': isReviewer,
        'role': role,
        'phone': phone,
        'google_id': googleId,
        'apple_id': appleId,
        'deleted_at': deletedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
