import 'package:flutter/material.dart';

class IndexStackProvider with ChangeNotifier {
  int _currentIndex = 0;
  final List<bool> _initializedScreens = [
    true,
    false,
    false,
    false
  ]; // Only first screen loaded initially

  int get currentIndex => _currentIndex;
  List<bool> get initializedScreens => _initializedScreens;

  void setIndex(int index) {
    if (!_initializedScreens[index]) {
      _initializedScreens[index] = true;
      notifyListeners();
    }
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}
