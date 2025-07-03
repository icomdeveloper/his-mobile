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
    ),
    token: currentData.token,
  );

  // Save updated settings
  await saveUserData(user: data);
}
