import 'package:his/core/services/shared_preferences.dart';
import 'dart:convert';

class LikesManager {
  // static const String _prefsKey = 'liked_media';

  // Toggle like status
  static Future<void> toggleLike(int mediaId, String prefsKey) async {
    final likesMap = await getLikesMap(prefsKey: prefsKey);

    final currentStatus = likesMap[mediaId] ?? false;
    likesMap[mediaId] = !currentStatus;

    // Convert Map<int, bool> to Map<String, bool> for JSON
    final stringMap =
        likesMap.map((key, value) => MapEntry(key.toString(), value));
    await Prefs.setString(prefsKey, json.encode(stringMap));
  }

  // Check if media is liked
  static Future<bool> isLiked(int mediaId, String prefsKey) async {
    final likesMap = await getLikesMap(prefsKey: prefsKey);
    return likesMap[mediaId] ?? false;
  }

  // Get all likes as a map
  static Future<Map<int, bool>> getLikesMap({required String prefsKey}) async {
    final jsonString = Prefs.getString(prefsKey);

    if (jsonString == null) return {};

    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      return decoded
          .map((key, value) => MapEntry(int.parse(key), value as bool));
    } catch (e) {
      print('Error parsing likes: $e');
      return {};
    }
  }
}
