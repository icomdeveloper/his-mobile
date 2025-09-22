import 'package:firebase_auth/firebase_auth.dart';

class UserInformation {
  int? id;
  String? name;
  String? email;
  dynamic profileImage;
  String? phone;
  dynamic emailVerifiedAt;
  String? role;
  dynamic googleId;
  dynamic appleId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fcmToken;
  String? academicTitle;
  String? jobDescription;
  DateTime? yearOfGraduation;
  String? countryOfPractices;
  String? institution;
  String? department;
  String? countryOfGraduation;

  UserInformation({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.phone,
    this.emailVerifiedAt,
    this.role,
    this.googleId,
    this.appleId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.academicTitle,
    this.jobDescription,
    this.yearOfGraduation,
    this.countryOfPractices,
    this.institution,
    this.department,
    this.countryOfGraduation,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profileImage: json['profile_image'] as dynamic,
      phone: json['phone'] as String?,
      emailVerifiedAt: json['email_verified_at'] as dynamic,
      role: json['role'] as String?,
      googleId: json['google_id'] as dynamic,
      appleId: json['apple_id'] as dynamic,
      deletedAt: json['deleted_at'] as dynamic,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      fcmToken: json['fcm_token'] as String?,
      academicTitle: json['academic_title'] as String?,
      jobDescription: json['job_description'] as String?,
      yearOfGraduation: json['year_of_graduation'] as DateTime?,
      countryOfPractices: json['country_of_practices'] as String?,
      institution: json['institution'] as String?,
      department: json['department'] as String?,
      countryOfGraduation: json['country_of_graduation'] as String?,
    );
  }

  factory UserInformation.fromFirebase(User user) => UserInformation(
        id: user.uid.hashCode,
        name: user.displayName ?? '',
        email: user.email ?? '',
        emailVerifiedAt: '',
        role: '',
        googleId: '',
        appleId: '',
        profileImage: '',
        phone: user.phoneNumber ?? '',
        createdAt: user.metadata.creationTime ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'profile_image': profileImage,
        'phone': phone,
        'email_verified_at': emailVerifiedAt,
        'role': role,
        'google_id': googleId,
        'apple_id': appleId,
        'deleted_at': deletedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'fcm_token': fcmToken,
        'academic_title': academicTitle,
        'job_description': jobDescription,
        'year_of_graduation': yearOfGraduation,
        'country_of_practices': countryOfPractices,
        'institution': institution,
        'department': department,
        'country_of_graduation': countryOfGraduation,
      };
}
