import 'dart:convert';
import 'dart:developer';

import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';
import 'package:his/features/authentication/data/models/user_data/user_data.dart';

UserData getUserData() {
  try {
    var user = Prefs.getString(PrefsKeys.userData);
    log('Token==>${UserData.fromJson(json.decode(user)).token}');
    return UserData.fromJson(json.decode(user));
  } catch (e) {
    return UserData();
  }
}
