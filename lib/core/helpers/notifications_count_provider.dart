import 'package:flutter/foundation.dart';
import 'package:his/constants.dart';
import 'package:his/core/services/shared_preferences.dart';

class NotificationsCountProvider with ChangeNotifier {
  static const _key = PrefsKeys.unReadNotificationCount;
  static const _readKey = PrefsKeys.readNotificationCount;
  int _unreadCount = 0;
  int _readCount = 0;

  int get unreadCount => _unreadCount;
  int get readCount => _readCount;

  NotificationsCountProvider() {
    _loadCount();
  }

  Future<void> _loadCount() async {
    _unreadCount = Prefs.getInt(_key) ?? 0;
    _readCount = Prefs.getInt(_readKey) ?? 0;
    notifyListeners();
  }

  Future<void> _saveCount() async {
    await Prefs.setInt(_key, _unreadCount);
    await Prefs.setInt(_readKey, _readCount);
  }

  void addNotifications(int count) {
    if (count == Prefs.getInt(_key)) return;
    if ((_unreadCount + _readCount) == count) {
      return;
    } else {
      _unreadCount = 0;
      _unreadCount += count - _readCount;
      _saveCount();
      notifyListeners();
    }
  }

  void markAsRead(int count) {
    _unreadCount = (_unreadCount - count).clamp(0, 999);
    _readCount = (_readCount + count).clamp(0, 999);
    _saveCount();
    notifyListeners();
  }

  void clearAll() {
    _unreadCount = 0;
    _saveCount();
    notifyListeners();
  }
}
