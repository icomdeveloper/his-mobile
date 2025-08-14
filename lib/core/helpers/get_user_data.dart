import 'dart:convert';
import 'dart:developer';

import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';
import 'package:his/features/authentication/data/models/user_data/user_information.dart';

Future saveUserData({required UserData user}) async {
  var jsonData = jsonEncode(user.toJson());
  await Prefs.setString(PrefsKeys.userData, jsonData);
}

Future removeUserData() async {
  await Prefs.remove(PrefsKeys.userData);
}

UserData getUserData() {
  try {
    var user = Prefs.getString(PrefsKeys.userData);
    log('Token==>${UserData.fromJson(json.decode(user)).token}');
    return UserData.fromJson(json.decode(user));
  } catch (e) {
    return UserData();
  }
}

Future<void> updateUserData({
  String? name,
  String? phone,
}) async {
  // Get current settings
  final currentData = getUserData();

  var data = currentData;
  // Update only the provided fields
  data = UserData(
    message: currentData.message,
    userInfo: UserInformation(
      profileImage: currentData.userInfo?.profileImage,
      id: currentData.userInfo?.id,
      email: currentData.userInfo?.email,
      name: name ?? currentData.userInfo?.name,
      phone: phone ?? currentData.userInfo?.phone,
      createdAt: currentData.userInfo?.createdAt,
      updatedAt: currentData.userInfo?.updatedAt,
      role: currentData.userInfo?.role,
      googleId: currentData.userInfo?.googleId,
      appleId: currentData.userInfo?.appleId,
      deletedAt: currentData.userInfo?.deletedAt,
      emailVerifiedAt: currentData.userInfo?.emailVerifiedAt,
      fcmToken: currentData.userInfo?.fcmToken,
      academicTitle: currentData.userInfo?.academicTitle,
      jobDescription: currentData.userInfo?.jobDescription,
      yearOfGraduation: currentData.userInfo?.yearOfGraduation,
      countryOfPractices: currentData.userInfo?.countryOfPractices,
      institution: currentData.userInfo?.institution,
      department: currentData.userInfo?.department,
      countryOfGraduation: currentData.userInfo?.countryOfGraduation,
    ),
    token: currentData.token,
  );

  // Save updated settings
  await saveUserData(user: data);
}

Future<void> updateUserProfileImage({
  String? profileImage,
}) async {
  // Get current settings
  final currentData = getUserData();

  var data = currentData;
  // Update only the provided fields
  data = UserData(
    message: currentData.message,
    userInfo: UserInformation(
      profileImage: profileImage ?? currentData.userInfo?.profileImage,
      id: currentData.userInfo?.id,
      email: currentData.userInfo?.email,
      name: currentData.userInfo?.name,
      phone: currentData.userInfo?.phone,
      createdAt: currentData.userInfo?.createdAt,
      updatedAt: currentData.userInfo?.updatedAt,
      role: currentData.userInfo?.role,
      googleId: currentData.userInfo?.googleId,
      appleId: currentData.userInfo?.appleId,
      deletedAt: currentData.userInfo?.deletedAt,
      emailVerifiedAt: currentData.userInfo?.emailVerifiedAt,
      fcmToken: currentData.userInfo?.fcmToken,
      academicTitle: currentData.userInfo?.academicTitle,
      jobDescription: currentData.userInfo?.jobDescription,
      yearOfGraduation: currentData.userInfo?.yearOfGraduation,
      countryOfPractices: currentData.userInfo?.countryOfPractices,
      institution: currentData.userInfo?.institution,
      department: currentData.userInfo?.department,
      countryOfGraduation: currentData.userInfo?.countryOfGraduation,
    ),
    token: currentData.token,
  );

  // Save updated settings
  await saveUserData(user: data);
}

Future<void> updateUserInfo({
  required UserInformation? userInfo,
}) async {
  // Get current settings
  final currentData = getUserData();

  var data = currentData;
  // Update only the provided fields
  data = UserData(
    message: currentData.message,
    userInfo: UserInformation(
      profileImage: userInfo?.profileImage,
      id: userInfo?.id,
      email: userInfo?.email,
      name: userInfo?.name,
      phone: userInfo?.phone,
      createdAt: userInfo?.createdAt,
      updatedAt: userInfo?.updatedAt,
      role: userInfo?.role,
      googleId: userInfo?.googleId,
      appleId: userInfo?.appleId,
      deletedAt: userInfo?.deletedAt,
      emailVerifiedAt: userInfo?.emailVerifiedAt,
      fcmToken: userInfo?.fcmToken,
      academicTitle: userInfo?.academicTitle,
      jobDescription: userInfo?.jobDescription,
      yearOfGraduation: userInfo?.yearOfGraduation,
      countryOfPractices: userInfo?.countryOfPractices,
      institution: userInfo?.institution,
      department: userInfo?.department,
      countryOfGraduation: userInfo?.countryOfGraduation,
    ),
    token: currentData.token,
  );

  // Save updated settings
  await saveUserData(user: data);
}
