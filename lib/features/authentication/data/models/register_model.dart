import 'dart:io';

import 'package:his/core/utils/api_endpoints.dart';

class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;
  final String phone;
  final File? image;
  final String? academicTitle;
  final String? jobDescription;
  final String? countryOfPractice;
  final String? institution;
  final String? department;
  final String? countryOfGraduation;
  final DateTime? yearOfGraduation;
  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    this.image,
    this.role = 'user',
    this.academicTitle,
    this.jobDescription,
    this.countryOfPractice,
    this.institution,
    this.department,
    this.countryOfGraduation,
    this.yearOfGraduation,
  });
  toJson() {
    return {
      ApiEndpoints.name: name,
      ApiEndpoints.email: email,
      ApiEndpoints.password: password,
      ApiEndpoints.passwordConfirmation: confirmPassword,
      ApiEndpoints.role: role,
      ApiEndpoints.phone: phone,
      ApiEndpoints.profileImage: image,
      ApiEndpoints.academicTitle: academicTitle,
      ApiEndpoints.jobDescription: jobDescription,
      ApiEndpoints.countryOfPractices: countryOfPractice,
      ApiEndpoints.institution: institution,
      ApiEndpoints.department: department,
      ApiEndpoints.countryOfGraduation: countryOfGraduation,
      ApiEndpoints.yearOfGraduation: yearOfGraduation
    };
  }
}
