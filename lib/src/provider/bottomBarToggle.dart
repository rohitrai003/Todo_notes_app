import 'package:flutter/material.dart';

class BottomBarToggle extends ChangeNotifier {
  int index = 0;
  toggleItems(int currentIndex) {
    index = currentIndex;
    notifyListeners();
  }
}
