import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LikesManager {
  static const String _prefsKey = 'liked_media';

  // Toggle like status
  static Future<void> toggleLike(int mediaId) async {
    final prefs = await SharedPreferences.getInstance();
    final likesMap = await getLikesMap();

    final currentStatus = likesMap[mediaId] ?? false;
    likesMap[mediaId] = !currentStatus;

    // Convert Map<int, bool> to Map<String, bool> for JSON
    final stringMap =
        likesMap.map((key, value) => MapEntry(key.toString(), value));
    await prefs.setString(_prefsKey, json.encode(stringMap));
  }

  // Check if media is liked
  static Future<bool> isLiked(int mediaId) async {
    final likesMap = await getLikesMap();
    return likesMap[mediaId] ?? false;
  }

  // Get all likes as a map
  static Future<Map<int, bool>> getLikesMap() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);

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
